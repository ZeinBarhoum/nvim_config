return { -- folke's utility collection. Every module is opt-in.
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false, -- bigfile/quickfile must hook before the first buffer is read
	opts = {
		-- Enabled: things nothing else in this config provides.
		bigfile = { enabled = true }, -- skip treesitter/LSP on huge files
		quickfile = { enabled = true }, -- render the file before loading plugins
		notifier = { enabled = true }, -- replaces vim.notify with a real UI
		input = { enabled = true }, -- replaces vim.ui.input, upgrades the grn rename prompt
		scratch = { enabled = true },
		gitbrowse = { enabled = true },
		rename = { enabled = true }, -- LSP-aware file rename, hooks nvim-tree/oil
		lazygit = { enabled = true },
		-- Requires the kitty graphics protocol (TERM=xterm-kitty here, so OK).
		-- Some formats additionally want the ImageMagick `magick` CLI, which is not
		-- installed -- only `convert` (ImageMagick 6) is. PNG previews still work.
		image = { enabled = true },

		-- Disabled: a working plugin already owns each of these. Turning them on
		-- would mean two plugins fighting over the same UI surface.
		picker = { enabled = false }, -- telescope.nvim
		explorer = { enabled = false }, -- nvim-tree.lua
		indent = { enabled = false }, -- indent-blankline.nvim
		zen = { enabled = false }, -- zen-mode.nvim
		dashboard = { enabled = false },
		statuscolumn = { enabled = false },
		scroll = { enabled = false },
		-- `words` binds ]] / [[, which are builtin section motions. Left off.
		words = { enabled = false },
	},
	keys = {
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle scratch buffer",
		},
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			mode = { "n", "v" },
			desc = "git [B]rowse (open in remote)",
		},
		{
			"<leader>cR",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "[C]ode [R]ename file (LSP-aware)",
		},
		-- NOTE: the lazygit module is enabled but the `lazygit` binary is NOT installed,
		-- so no key is bound to it yet. To enable, install lazygit and add:
		--   { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
	},
}
