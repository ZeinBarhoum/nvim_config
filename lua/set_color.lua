vim.cmd.colorscheme("NeoSolarized")
vim.cmd.hi("Comment gui=none")
local is_transparent = vim.g.transparent_background or false
if is_transparent then
	vim.cmd.hi("Normal guibg=NONE ctermbg=NONE")
end
