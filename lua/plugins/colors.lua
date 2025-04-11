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
			transparency = true,
		},
	},
}
local moonfly = {
	"bluz71/vim-moonfly-colors",
	name = "moonfly",
	priority = 1000,
}
local nightbox = {
	"EdenEast/nightfox.nvim",
}
local oxocarbon = {
	"nyoom-engineering/oxocarbon.nvim",
}
local github_theme = {
	"projekt0n/github-nvim-theme",
	config = function()
		require("github-theme").setup({
			options = {
				transparent = true,
			},
		})
	end,
}
return { tokyo, monokai, solarized, catppuccino, onedardk, rose_pine, moonfly, nightbox, oxocarbon, github_theme }
