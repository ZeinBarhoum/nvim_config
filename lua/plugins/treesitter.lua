return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	branch = "main", -- pin: `master` is legacy and in maintenance only
	lazy = false, -- the `main` rewrite does not support lazy-loading
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		local ts_config = require("nvim-treesitter.config")

		ts.setup({})

		ts.install({
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
			"python",
			"cpp",
			"latex",
		})

		-- vimtex provides better latex highlighting than the treesitter parser
		local no_highlight = { latex = true }
		local no_indent = { ruby = true }

		-- Replaces the old `auto_install = true`: remember what we already tried
		-- so a missing parser is not re-requested on every FileType event.
		local attempted = {}

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
			callback = function(ev)
				local lang = vim.treesitter.language.get_lang(ev.match)
				if not lang then
					return
				end

				if not vim.list_contains(ts_config.get_installed("parsers"), lang) then
					if not attempted[lang] and vim.list_contains(ts_config.get_available(), lang) then
						attempted[lang] = true
						ts.install({ lang })
					end
					return
				end

				if no_highlight[lang] then
					return
				end

				vim.treesitter.start(ev.buf, lang)

				if not no_indent[lang] then
					vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end

				-- window-local, so it applies to every window showing this buffer
				vim.wo[0][0].foldmethod = "expr"
				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			end,
		})
	end,
}
