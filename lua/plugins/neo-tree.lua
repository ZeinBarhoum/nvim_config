return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal" },
		{ "<C-n>", ":Neotree reveal<CR>", desc = "NeoTree reveal" },
	},
	opts = {
		filesystem = {
			window = {
				mappings = {
					["\\"] = "close_window",
					["<C-n>"] = "close_window",
				},
			},
			filtered_items = {
				visible = true,
				hide_dotfiles = true,
				hide_gitignored = true,
			},
		},
	},
}
