return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap",
		"mfussenegger/nvim-dap-python", --optional
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
