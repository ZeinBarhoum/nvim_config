return {
	-- which-key prefers mini.icons over nvim-web-devicons. Rather than loading it
	-- eagerly, register a package.preload shim: the first plugin to require
	-- "nvim-web-devicons" pulls in mini.icons and mocks the devicons API, so every
	-- existing consumer (lualine, nvim-tree, telescope, barbar) keeps working.
	"echasnovski/mini.icons",
	lazy = true,
	opts = {},
	init = function()
		package.preload["nvim-web-devicons"] = function()
			require("mini.icons").mock_nvim_web_devicons()
			return package.loaded["nvim-web-devicons"]
		end
	end,
}
