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
		})
	end,
}
