vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.pumheight = 10 -- limit completion items
vim.opt.laststatus = 3

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.cmd([[
  autocmd BufEnter *.py :setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent
  autocmd BufEnter *.cc :setlocal tabstop=2 softtabstop=4 shiftwidth=2 expandtab autoindent
  autocmd BufEnter *.cpp :setlocal tabstop=2 softtabstop=4 shiftwidth=2 expandtab autoindent
  autocmd BufEnter *.h :setlocal tabstop=2 softtabstop=4 shiftwidth=2 expandtab autoindent
  autocmd BufEnter *.hpp :setlocal tabstop=2 softtabstop=4 shiftwidth=2 expandtab autoindent
]])

-- for .launch files on ROS
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.launch",
	command = "set filetype=xml",
})
