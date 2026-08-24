--- Partial acceptance of `vim.lsp.inline_completion` suggestions.
---
--- Neovim 0.12 only offers all-or-nothing acceptance via
--- `vim.lsp.inline_completion.get()`. This adds word-wise and line-wise accept
--- on top, using the `on_accept` hook: returning nil from it suppresses the
--- default full insert, leaving us to apply just the slice we want.
---
--- NOTE: codecompanion.nvim ships an equivalent module
--- (interactions/inline/completion.lua) which does NOT work on 0.12 -- it reads
--- `item.range.start.row` / `item.range.end_.row`, but `vim.Range` is flat
--- (start_row/start_col/end_row/end_col via an __index metatable, see
--- runtime/lua/vim/range.lua:39). `range.start` is therefore nil and it raises
--- "attempt to index field 'start' (a nil value)". Its own header marks it
--- unsupported, so this is a local reimplementation rather than a patch.

local M = {}

---Leading whitespace + punctuation + one word + trailing whitespace.
---@param text string
---@return string|nil
local function next_word(text)
	local _, stop = text:find("^%s*%p*[^%s%p]*%s*")
	if stop and stop > 0 then
		return text:sub(1, stop)
	end
	return nil
end

---Up to and including the next newline. A leading newline is skipped so that
---the first press yields real content rather than just a line break.
---@param text string
---@return string|nil
local function next_line(text)
	if not text or text == "" then
		return nil
	end
	local nl = text:find("\n")
	if not nl then
		return text
	end
	if nl == 1 then
		local second = text:find("\n", 2)
		return second and text:sub(1, second) or text
	end
	return text:sub(1, nl)
end

---@param item table vim.lsp.inline_completion.Item
---@return string|nil
local function insert_text_of(item)
	local text = item.insert_text
	if type(text) == "table" then
		text = text.value
	end
	return type(text) == "string" and text or nil
end

---@param extract fun(text: string): string|nil
---@return boolean accepted True when a suggestion was on screen to act on.
local function accept_partial(extract)
	-- IMPORTANT: the return value is `get()`'s, not a flag set inside on_accept.
	-- `get()` returns true/false synchronously but runs on_accept via vim.schedule
	-- (see runtime/lua/vim/lsp/inline_completion.lua:465), so any flag the callback
	-- sets is still false when this function returns -- which made every press look
	-- like a miss and fall through to the fallback key.
	return vim.lsp.inline_completion.get({
		on_accept = function(item)
			local text = insert_text_of(item)
			if not text or text == "" then
				return nil
			end

			local row, col = unpack(vim.api.nvim_win_get_cursor(0))
			row = row - 1 -- to 0-indexed

			local start_row, start_col, end_row, end_col = row, col, row, col
			if item.range then
				start_row, start_col, end_row, end_col = item.range:to_extmark()
			end

			-- The suggestion includes whatever has already been typed inside the
			-- range, so strip that prefix before slicing.
			if start_row < row or (start_row == row and start_col < col) then
				local ok, existing = pcall(vim.api.nvim_buf_get_text, 0, start_row, start_col, row, col, {})
				if ok then
					local typed = table.concat(existing, "\n")
					if typed ~= "" and vim.startswith(text, typed) then
						text = text:sub(#typed + 1)
					end
				end
			end

			local piece = extract(text)
			if not piece or piece == "" then
				return nil
			end

			-- Never let the replaced region start before the cursor.
			if end_row < row or (end_row == row and end_col < col) then
				end_row, end_col = row, col
			end

			local lines = vim.split(piece, "\n", { plain = true })
			vim.api.nvim_buf_set_text(0, row, col, end_row, end_col, lines)

			local new_row, new_col
			if #lines > 1 then
				new_row, new_col = row + #lines - 1, #lines[#lines]
			else
				new_row, new_col = row, col + #lines[1]
			end
			vim.api.nvim_win_set_cursor(0, { new_row + 1, new_col })

			return nil -- suppress the default full-completion insert
		end,
	})
end

---@return boolean accepted
function M.accept_word()
	return accept_partial(next_word)
end

---@return boolean accepted
function M.accept_line()
	return accept_partial(next_line)
end

return M
