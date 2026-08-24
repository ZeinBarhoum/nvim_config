return {
	"christoomey/vim-tmux-navigator",
	event = "VeryLazy",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
	},
	keys = {
		{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Go to window/tmux pane left" },
		{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Go to window/tmux pane below" },
		{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Go to window/tmux pane above" },
		{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Go to window/tmux pane right" },
		{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Go to previous window/tmux pane" },
	},
}
