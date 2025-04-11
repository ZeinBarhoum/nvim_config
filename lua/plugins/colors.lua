local tokyo = {
	"folke/tokyonight.nvim",
	priority = 1000, -- Make sure to load this before all the other start plugins.
}
local monokai = {
	"loctvl842/monokai-pro.nvim",
	priority = 1000,
	opts = {
		filter = "classic",
	},
}
local solarized = {
	"Tsuzat/NeoSolarized.nvim",
	priority = 1000,
}
local catppuccino = {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		transparent_background = true,
	},
}
local onedardk = {
	"navarasu/onedark.nvim",
	priority = 1000,
}

local rose_pine = {
	"rose-pine/neovim",
	name = "rose-pine",
	opts = {
		styles = {
			transparency = false,
		},
	},
}

return { tokyo, monokai, solarized, catppuccino, onedardk, rose_pine }
