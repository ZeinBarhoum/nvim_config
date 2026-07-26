return { -- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} }, -- NOTE: Must be loaded before dependants
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					-- luv types ship with lua_ls; the separate luvit-meta plugin is obsolete
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		local lsp_group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true })
		local highlight_group = vim.api.nvim_create_augroup("user-lsp-highlight", { clear = true })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = lsp_group,
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if not client then
					return
				end

				-- NOTE: method call (`client:`), the dot form is removed in 0.13
				if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_group,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_group,
						callback = vim.lsp.buf.clear_references,
					})
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion) then
					vim.lsp.inline_completion.enable(true, { bufnr = event.buf })

					local ic = vim.lsp.inline_completion

					-- These are NOT expr mappings: an expr mapping may not change the
					-- buffer (E565), and accepting a completion does exactly that, so
					-- the fallback is replayed with feedkeys instead.
					-- "n" = no remap, so <C-w> below cannot recurse into itself. Do NOT
					-- add "x": executing inline from a mapping callback drops out of
					-- insert mode, which breaks the very fallback this exists for.
					local function feed(keys)
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", false)
					end

					-- <C-l>'s fallback is done directly rather than by feeding <Right>:
					-- a fed key is subject to whatever else is listening in insert mode,
					-- whereas this is deterministic. i_CTRL-W has no such API, so it
					-- stays on feed() above.
					local function cursor_right()
						local row, col = unpack(vim.api.nvim_win_get_cursor(0))
						if col < #vim.api.nvim_get_current_line() then
							vim.api.nvim_win_set_cursor(0, { row, col + 1 })
						end
					end

					-- Word/line-wise accept: 0.12 only offers all-or-nothing natively.
					-- See lua/inline_accept.lua for why codecompanion's equivalent
					-- helper is not used (it crashes on 0.12's vim.Range).
					local function partial(fn)
						local ok, accepted = pcall(function()
							return require("inline_accept")[fn]()
						end)
						if not ok then
							vim.notify("inline_accept." .. fn .. ": " .. tostring(accepted), vim.log.levels.ERROR)
							return false
						end
						return accepted
					end

					local function imap(lhs, rhs, desc)
						vim.keymap.set("i", lhs, rhs, { buffer = event.buf, desc = "Copilot: " .. desc })
					end

					-- Every key keeps its original meaning when no suggestion is on
					-- screen, so nothing is lost. i_CTRL-W (delete word before cursor)
					-- is a builtin and stays intact; <C-l> falls back to the insert-mode
					-- cursor-right alias from mappings.lua.
					imap("<C-w>", function()
						if not partial("accept_word") then
							feed("<C-w>")
						end
					end, "accept word (else delete word)")

					imap("<C-l>", function()
						if not partial("accept_line") then
							cursor_right()
						end
					end, "accept line (else cursor right)")

					-- <C-CR> encodes distinctly from <CR> (\x80\xFC\x04\x0D vs \x0D),
					-- so this does not clash with nvim-cmp's <CR> confirm. Requires a
					-- terminal that sends it; kitty does.
					imap("<C-CR>", function()
						ic.get()
					end, "accept full completion")

					vim.keymap.set("n", "<leader>ti", function()
						ic.enable(not ic.is_enabled({ bufnr = event.buf }), { bufnr = event.buf })
					end, { buffer = event.buf, desc = "[T]oggle [I]nline completion (Copilot)" })
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					vim.keymap.set("n", "<leader>th", function()
						local filter = { bufnr = event.buf }
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
					end, { buffer = event.buf, desc = "LSP: [T]oggle Inlay [H]ints" })
				end
			end,
		})

		vim.api.nvim_create_autocmd("LspDetach", {
			group = lsp_group,
			callback = function(event)
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = event.buf })
			end,
		})

		-- Defaults inherited by every server
		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

		-- Per-server overrides, merged over nvim-lspconfig's `lsp/<name>.lua`
		vim.lsp.config("clangd", {
			cmd = { "clangd", "--clang-tidy" },
		})

		-- Ghost-text completion via Neovim 0.12's native vim.lsp.inline_completion.
		-- No plugin involved: copilot-language-server implements
		-- textDocument/inlineCompletion and Neovim renders it.
		--
		-- The proxy is read from ~/.copilot/settings.json (the Copilot CLI's config).
		-- The language server does NOT read that file itself -- it only takes
		-- settings.http.proxy over LSP -- so without this the requests would go out
		-- direct and bypass the local proxy.
		local function copilot_proxy()
			local fd = io.open(vim.fn.expand("~/.copilot/settings.json"), "r")
			if not fd then
				return nil
			end
			local raw = fd:read("*a")
			fd:close()
			local ok, decoded = pcall(vim.json.decode, raw)
			if ok and type(decoded) == "table" then
				return decoded.proxyUrl
			end
		end

		vim.lsp.config("copilot", {
			settings = {
				http = { proxy = copilot_proxy() },
			},
		})
		vim.lsp.enable("copilot")

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})

		local servers = {
			"clangd",
			"pyright",
			"texlab",
			-- NOTE: cmake-language-server 0.1.11 depends on `pygls` with no upper
			-- bound, but pygls 2.x removed `LanguageServer` from `pygls.server`, so a
			-- fresh Mason install crashes on startup with an ImportError and the
			-- server silently never attaches. If that returns after a Mason update:
			--   ~/.local/share/nvim/mason/packages/cmake-language-server/venv/bin/pip \
			--     install "pygls<2"
			"cmake",
			"rust_analyzer", -- was "rust-analyzer", which is not a valid server name
			"lua_ls",
			"bashls",
		}

		require("mason-lspconfig").setup({
			ensure_installed = servers,
			-- Enable only these, and only once installed. Leaving `automatic_enable`
			-- at its `true` default would also start formatters that happen to ship an
			-- LSP mode (nvim-lspconfig has lsp/stylua.lua and lsp/taplo.lua), so
			-- stylua would run as a language server alongside conform.
			automatic_enable = vim.list_extend(vim.deepcopy(servers), { "autotools_ls" }),
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				-- NOTE: do NOT add "tree-sitter-cli" here. Mason ships a prebuilt binary
				-- linked against GLIBC_2.39; Ubuntu 22.04 has 2.35, so it fails to run
				-- and, because mason/bin precedes /usr/bin, it shadows a working copy.
				-- Install it with `cargo install tree-sitter-cli` instead.
				"stylua",
				"black",
				"docformatter",
				"mdformat",
				"xmlformatter",
				-- Pinned: newer clang-format releases reformat existing code.
				{ "clang-format", version = "20.1.3" },
				"latexindent",
				"tex-fmt",
				"yamlfix",
				-- cmakelang ships BOTH cmake-format (conform) and cmake-lint (nvim-lint).
				"cmakelang",
				"taplo",
				-- Linters for nvim-lint (see lua/plugins/lint.lua). shellcheck does
				-- double duty: bash-language-server invokes it directly when it is on
				-- PATH, so bashls diagnostics improve whether or not nvim-lint runs.
				"shellcheck",
				"ruff",
				"markdownlint-cli2",
				"yamllint",
				-- Ghost-text completion. Installed here rather than via
				-- mason-lspconfig's ensure_installed because mason-lspconfig has no
				-- mapping for it, so it is enabled with vim.lsp.enable() below.
				"copilot-language-server",
			},
		})
	end,
}
