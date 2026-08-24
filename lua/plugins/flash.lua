return { -- Jump anywhere on screen with labels. Replaces leap.nvim, which was
	-- installed with no keybindings at all and so never did anything.
	"folke/flash.nvim",
	event = "VeryLazy",
	-- Carried over from the old leap.lua spec so removing it does not silently drop
	-- dot-repeat support for the other tpope-style plugins.
	dependencies = { "tpope/vim-repeat" },
	opts = {},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash jump",
		},
		{
			-- IMPORTANT: no "x" here. nvim-surround owns visual-mode S (surround the
			-- selection); binding flash to it would shadow that.
			"S",
			mode = { "n", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash treesitter select",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote flash (operator-pending)",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter search",
		},
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle flash while searching",
		},
	},
}
