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
		keys = {
			{ "<leader>z", ":ZenMode<CR>", desc = "Zen Mode toggle" },
		},
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
