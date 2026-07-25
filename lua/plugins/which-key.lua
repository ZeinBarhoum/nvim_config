return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup()

		-- Document existing key chains
		require("which-key").add({
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>d", group = "[D]ebug" },
			{ "<leader>r", group = "[R]efactor / [R]ename" },
			{ "<leader>f", group = "[F]ind" },
			{ "<leader>w", group = "[W]indow" },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>l", group = "[L]SP" },
			{ "<leader>g", group = "[G]it hunk", mode = { "n", "v" } },
			{ "<leader>h", group = "[H]arpoon" },

			-- vim-tmux-navigator creates these itself in plugin/tmux_navigator.vim with
			-- no desc, replacing lazy's `keys` placeholders once it loads. These entries
			-- carry no rhs, so which-key labels them without remapping and the plugin
			-- keeps ownership (including its terminal-mode fzf guard).
			{ "<C-h>", desc = "Go to window/tmux pane left" },
			{ "<C-j>", desc = "Go to window/tmux pane below" },
			{ "<C-k>", desc = "Go to window/tmux pane above" },
			{ "<C-l>", desc = "Go to window/tmux pane right" },
			{ "<C-\\>", desc = "Go to previous window/tmux pane" },
		})
	end,
}
