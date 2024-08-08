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
		{ "<C-n>", ":Neotree toggle<CR>", desc = "NeoTree toggle" },
	},
	opts = {
		filesystem = {
			filtered_items = {
				visible = true,
				hide_dotfiles = true,
				hide_gitignored = true,
			},
		},
	},
	enabled = false, -- disable
}
