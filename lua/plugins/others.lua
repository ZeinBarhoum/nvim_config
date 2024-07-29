return {
	{

		"ggandor/leap.nvim",
		lazy = false,
		dependencies = {
			"tpope/vim-repeat",
		},
	},
	{
		"mbbill/undotree",
		event = "VeryLazy",
	},
	{
		"folke/zen-mode.nvim",
		event = "VeryLazy",
		opts = {
			window = {
				width = 160,
			},
		},
	},
	{
		"fladson/vim-kitty",
		event = "VeryLazy",
	},
}
