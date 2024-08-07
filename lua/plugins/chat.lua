return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		version = "2.11.1",
		event = "VeryLazy",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			debug = false, -- Enable debugging
			window = {
				layout = "float",
				relative = "editor",
				width = 0.6,
				height = 0.8,
			},
		},
	},
}
