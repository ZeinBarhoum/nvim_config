return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap",
		"mfussenegger/nvim-dap-python", --optional
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
	},
	lazy = false,
	config = function()
		require("venv-selector").setup({
			settings = {
				search = {
					micromamba = {
						command = "fd --full-path '.*/python$' --type symlink ~/micromamba/envs",
					},
					mamba = {
						command = "fd --full-path '.*/python$' --type symlink ~/mamba/envs",
					},
					conda = {
						command = "fd --full-path '.*/python$' --type symlink ~/conda/envs",
					},
				},
			},
		})
	end,
}
