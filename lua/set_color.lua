-- vim.cmd.colorscheme("catppuccin-mocha")
vim.cmd.colorscheme("github_dark_high_contrast")
vim.cmd.hi("Comment gui=none")
local is_transparent = vim.g.transparent_background or false
if is_transparent then
	vim.cmd.hi("Normal guibg=NONE ctermbg=NONE")
end
