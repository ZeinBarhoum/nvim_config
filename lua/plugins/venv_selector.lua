return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap",
		"mfussenegger/nvim-dap-python", --optional
	},
	lazy = false,
	config = function()
		-- NOTE: setup() merges its argument straight onto the defaults, so `search`
		-- must be top-level. Wrapping it in `settings = { ... }` silently orphans it.
		require("venv-selector").setup({
			-- `$FD` is substituted with the detected fd binary; hardcoding "fd"
			-- breaks on Debian/Ubuntu, where the binary is named `fdfind`.
			search = {
				micromamba = {
					command = "$FD --full-path '.*/python$' --type symlink ~/micromamba/envs",
				},
				mamba = {
					command = "$FD --full-path '.*/python$' --type symlink ~/mamba/envs",
				},
				conda = {
					command = "$FD --full-path '.*/python$' --type symlink ~/conda/envs",
				},
			},
		})
	end,
}
