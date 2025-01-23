return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
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
