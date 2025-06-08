return {
	"zbirenbaum/copilot.lua",
	event = "VeryLazy",
	config = function()
		require("copilot").setup({
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept_line = "<M-p>",
					accept_word = "<M-l>",
					accept = "<M-CR>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			panel = {
				enabled = true,
				auto_refresh = true,
				keymap = {
					jump_prev = "<M-[>",
					jump_next = "<M-]>",
					accept = "<M-CR>",
					refresh = "gr",
					open = "<C-CR>",
				},
				layout = {
					position = "right", -- | top | left | right | horizontal | vertical
					ratio = 0.4,
				},
			},
			filetypes = {
				["*"] = true,
			},
			copilot_model = "gpt-4o-copilot",
		})
	end,
}
