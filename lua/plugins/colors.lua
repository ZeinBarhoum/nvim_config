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
}
local onedardk = {
	"navarasu/onedark.nvim",
	priority = 1000,
}

return { tokyo, monokai, solarized, catppuccino, onedardk }
