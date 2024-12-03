return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "VeryLazy",
	config = function()
		require("copilot").setup({
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept_line = "<M-p>",
					accept_word = "<M-l>",
					accept = "<M-CR>",
				},
			},
			-- panel = {enabled = false},
		})
	end,
}
