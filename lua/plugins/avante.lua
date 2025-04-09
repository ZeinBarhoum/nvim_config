return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	opts = {
		provider = "copilot",
		auto_suggestions_provider = nil,
		cursor_applying_provider = nil, -- The provider used in the applying phase of Cursor Planning Mode, defaults to nil, when nil uses Config.provider as the provider for the applying phase
		dual_boost = {
			enabled = false,
		},
		behaviour = {
			auto_suggestions = false, -- Experimental stage
		},
		mappings = {
			--- @class AvanteConflictMappings
			diff = {
				ours = "co",
				theirs = "ct",
				all_theirs = "ca",
				both = "cb",
				cursor = "cc",
				next = "]]",
				prev = "[[",
			},
		},
		hints = { enabled = true },
		windows = {
			position = "right", -- the position of the sidebar
			width = 30, -- default % based on available width
			ask = {
				floating = false, -- Open the 'AvanteAsk' prompt in a floating window
				start_insert = false, -- Start insert mode when opening the ask window
			},
		},
		highlights = {
			diff = {
				current = "DiffText",
				incoming = "DiffAdd",
			},
		},
	},
	build = "make",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
	},
}
