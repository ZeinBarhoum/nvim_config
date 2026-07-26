return { -- Project-wide search AND replace. telescope's live_grep can only find.
	"MagicDuck/grug-far.nvim",
	cmd = "GrugFar",
	opts = {},
	-- Pairs with <leader>s in mappings.lua: lowercase substitutes in this buffer,
	-- uppercase searches and replaces across the project.
	--
	-- NOTE: requires ripgrep >= 14 (Ubuntu 22.04 ships 13). Installed via
	-- `cargo install ripgrep`, which lands in ~/.cargo/bin -- that precedes
	-- /usr/bin on PATH, so the newer binary wins for telescope too.
	--
	-- NOTE: grug-far's in-buffer keymaps use <localleader>, and this config sets
	-- maplocalleader to " " (same as mapleader, see set.lua:2). Inside the grug-far
	-- buffer those buffer-local maps shadow the global <leader> ones, which is
	-- harmless there but is why <localleader>r etc. read as <Space>r.
	keys = {
		{
			"<leader>S",
			function()
				require("grug-far").open()
			end,
			mode = "n",
			desc = "[S]earch and replace (project)",
		},
		{
			"<leader>S",
			function()
				require("grug-far").with_visual_selection()
			end,
			mode = "x",
			desc = "[S]earch and replace selection (project)",
		},
	},
}
