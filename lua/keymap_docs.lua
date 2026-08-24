--- `:Keymaps` -- open keymaps.html in the browser.
---
--- Firefox on Ubuntu is a snap, and snap's `home` interface deliberately excludes
--- hidden directories, so it cannot read anything under ~/.config/ no matter the
--- file permissions (a symlink does not help either -- AppArmor resolves it to the
--- real path). Serving over loopback sidesteps that entirely: python reads the
--- file and hands over bytes, so the sandbox never touches the filesystem.
---
--- Bound to 127.0.0.1 so the config directory is not exposed on the network, and
--- port 0 so the OS picks a free one rather than us guessing.

local M = {}

local state = {
	proc = nil,
	url = nil,
}

local function stop()
	if state.proc then
		pcall(function()
			state.proc:kill("sigterm")
		end)
	end
	state.proc, state.url = nil, nil
end

local function start(on_ready)
	local root = vim.fn.stdpath("config")
	if vim.fn.filereadable(root .. "/keymaps.html") == 0 then
		return vim.notify("keymaps.html not found in " .. root, vim.log.levels.ERROR)
	end
	if vim.fn.executable("python3") == 0 then
		return vim.notify("python3 not found; cannot serve keymaps.html", vim.log.levels.ERROR)
	end

	local answered = false
	-- -u so the "Serving HTTP on ..." banner is not held in a pipe buffer
	state.proc = vim.system({
		"python3",
		"-u",
		"-m",
		"http.server",
		"0",
		"--bind",
		"127.0.0.1",
		"--directory",
		root,
	}, {
		stdout = function(_, data)
			if answered or not data then
				return
			end
			local port = data:match("port (%d+)")
			if port then
				answered = true
				state.url = ("http://127.0.0.1:%s/keymaps.html"):format(port)
				vim.schedule(function()
					on_ready(state.url)
				end)
			end
		end,
	}, function()
		-- server exited (crash, or Neovim shutting down)
		state.proc, state.url = nil, nil
	end)
end

function M.open()
	if state.url then
		vim.ui.open(state.url)
		return
	end
	start(function(url)
		vim.ui.open(url)
		vim.notify("Keymap reference at " .. url, vim.log.levels.INFO)
	end)
end

vim.api.nvim_create_user_command("Keymaps", M.open, {
	desc = "Open the keymap cheatsheet in a browser",
})

vim.api.nvim_create_autocmd("VimLeavePre", {
	group = vim.api.nvim_create_augroup("keymap-docs", { clear = true }),
	callback = stop,
})

return M
