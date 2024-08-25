return {
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
}
