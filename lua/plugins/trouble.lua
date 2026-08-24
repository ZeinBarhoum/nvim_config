return { -- Live, foldable list for diagnostics / references / symbols
	"folke/trouble.nvim",
	cmd = "Trouble",
	opts = {},
	-- NOTE: the conventional prefix for Trouble is <leader>x, which is already
	-- barbar's BufferClose (see mappings.lua). Hence <leader>X.
	keys = {
		{ "<leader>Xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (workspace)" },
		{ "<leader>XX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (current buffer)" },
		{ "<leader>Xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (document)" },
		{ "<leader>Xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP definitions / references" },
		{ "<leader>XL", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
		{ "<leader>XQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
		{ "<leader>Xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo comments" },
	},
}
