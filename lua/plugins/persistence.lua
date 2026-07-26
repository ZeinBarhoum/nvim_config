return { -- Session save/restore per directory: buffers, window layout, folds
	-- Complements tmux-sessionizer (see mappings.lua), which switches projects but
	-- does not restore anything about the Neovim session inside them.
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {},
	keys = {
		{
			"<leader>ps",
			function()
				require("persistence").load()
			end,
			desc = "[P]ersistence: restore [S]ession for this directory",
		},
		{
			"<leader>pl",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "[P]ersistence: restore [L]ast session",
		},
		{
			"<leader>pd",
			function()
				require("persistence").stop()
			end,
			desc = "[P]ersistence: [D]on't save this session on exit",
		},
	},
}
