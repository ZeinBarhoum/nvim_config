
function ColorMyPencils(color)
    math.randomseed(os.time())
    -- local theme_number = math.random(1,3)
    local available_themes  = {"catppuccin-mocha","rose-pine", "gruvbox", "tokyonight", "tokyodark", "edge", "nightfly"}
	color = color or available_themes[1]
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
end
ColorMyPencils()
