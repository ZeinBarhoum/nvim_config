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
				"stylua",
				"black",
				"docformatter",
				"mdformat",
				"xmlformatter",
				"clang-format",
				"latexindent",
				"tex-fmt",
				"yamlfix",
				"cmakelang",
				"taplo",
			},
		})
	end,
}
