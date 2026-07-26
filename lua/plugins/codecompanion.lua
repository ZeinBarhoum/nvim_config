return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	cmd = { "CodeCompanionChat", "CodeCompanionActions" },
	opts = {
		interactions = {
			chat = { adapter = "claude_code" },
		},
	},
	keys = {
		{ "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "[A]I [A]ctions" },
		{ "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "[A]I [C]hat toggle" },
		{ "<leader>ad", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "[A]I a[D]d selection to chat" },
	},
}
