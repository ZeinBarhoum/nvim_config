-- NVCHAD mappings
-- Insert mode
vim.keymap.set('i', '<C-b>', '<ESC>^i', { desc = 'Beginning of line' })
vim.keymap.set('i', '<C-e>', '<End>', { desc = 'End of line' })
vim.keymap.set('i', '<C-h>', '<Left>', { desc = 'Move left' })
vim.keymap.set('i', '<C-l>', '<Right>', { desc = 'Move right' })
vim.keymap.set('i', '<C-j>', '<Down>', { desc = 'Move down' })
vim.keymap.set('i', '<C-k>', '<Up>', { desc = 'Move up' })

-- Normal mode
--vim.keymap.set('n', '<Esc>', '<cmd>noh<CR>', { desc = 'Clear highlights' })
--vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Window left' })
--vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Window right' })
--vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Window down' })
--vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Window up' })
-- duplicated
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<C-c>', '<cmd>%y+<CR>', { desc = 'Copy whole file' })
vim.keymap.set('n', '<leader>n', '<cmd>set nu!<CR>', { desc = 'Toggle line number' })
vim.keymap.set('n', '<leader>rn', '<cmd>set rnu!<CR>', { desc = 'Toggle relative number' })
vim.keymap.set('n', 'j', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = 'Move down', expr = true })
vim.keymap.set('n', 'k', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = 'Move up', expr = true })
vim.keymap.set('n', '<Up>', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = 'Move up', expr = true })
vim.keymap.set('n', '<Down>', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = 'Move down', expr = true })
vim.keymap.set('n', '<leader>b', '<cmd>enew<CR>', { desc = 'New buffer' })
vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end, { desc = 'LSP formatting' })

-- Terminal mode
--vim.keymap.set('t', '<C-x>', vim.api.nvim_replace_termcodes('<C-\\><C-N>', true, true, true), { desc = 'Escape terminal mode' })
-- duplicated

-- Visual mode
vim.keymap.set('v', '<Up>', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = 'Move up', expr = true })
vim.keymap.set('v', '<Down>', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = 'Move down', expr = true })
vim.keymap.set('v', '<', '<gv', { desc = 'Indent line' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent line' })

-- Visual-line mode
vim.keymap.set('x', 'j', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = 'Move down', expr = true })
vim.keymap.set('x', 'k', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = 'Move up', expr = true })
vim.keymap.set('x', 'p', 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = 'Dont copy replaced text', silent = true })


-- kickstart mapping
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- nvim-tree
vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle nvimtree' })
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeFocus<CR>', { desc = 'Focus nvimtree' })
