return {
	-- Maintained fork. norcalli/nvim-colorizer.lua has been unmaintained since
	-- mid-2024 and calls the deprecated `vim.tbl_flatten` (removed in 0.13).
	"catgoose/nvim-colorizer.lua",
	event = "VeryLazy",
	-- NOTE: the old plugin took `setup(filetypes, opts)` positionally, so `opts = {}`
	-- was read as an empty *filetype list* and nothing was ever colorized. This fork
	-- takes a single options table and defaults to all filetypes.
	opts = {},
}
