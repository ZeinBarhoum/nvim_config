return { -- Edit the filesystem as a normal buffer: rename/create/delete, then :w
	"stevearc/oil.nvim",
	dependencies = { "echasnovski/mini.icons" },
	cmd = "Oil",
	opts = {
		-- nvim-tree already sets hijack_netrw (see nvim-tree.lua), so leave netrw
		-- alone here; the two would otherwise race to own directory buffers.
		default_file_explorer = false,
		view_options = {
			show_hidden = true,
		},
	},
	keys = {
		{ "-", "<cmd>Oil<cr>", desc = "Open parent directory (oil)" },
	},
}
