-- NVCHAD mappings
-- Insert mode
vim.keymap.set("i", "<C-b>", "<ESC>^i", { desc = "Beginning of line" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "End of line" })
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })

-- Normal mode
--vim.keymap.set('n', '<Esc>', '<cmd>noh<CR>', { desc = 'Clear highlights' })
--vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Window left' })
--vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Window right' })
--vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Window down' })
--vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Window up' })
-- duplicated
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy whole file" })
vim.keymap.set("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line number" })
vim.keymap.set("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle relative number" })
vim.keymap.set("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
vim.keymap.set("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
vim.keymap.set("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
vim.keymap.set("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
vim.keymap.set("n", "<leader>b", "<cmd>enew<CR>", { desc = "New buffer" })
--vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end, { desc = 'LSP formatting' })
-- duplicated

-- Terminal mode
vim.keymap.set("t", "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), { desc = "Escape terminal mode" })

-- Visual mode
vim.keymap.set("v", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
vim.keymap.set("v", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
vim.keymap.set("v", "<", "<gv", { desc = "Indent line" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent line" })

-- Visual-line mode
vim.keymap.set("x", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
vim.keymap.set("x", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
vim.keymap.set("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Dont copy replaced text", silent = true })

-- kickstart mapping
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- telescope
-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>ff", function()
	builtin.find_files({ path_display = { "truncate" } })
end, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>ft", builtin.colorscheme, { desc = "[F]ind select [T]elescope" })
vim.keymap.set("n", "<leader>fw", function()
	builtin.grep_string({ path_display = { "truncate" } })
end, { desc = "[F]ind current [W]ord" })
vim.keymap.set("n", "<leader>fg", function()
	builtin.live_grep({ path_display = { "truncate" } })
end, { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "[F]ind [O]ld Files" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind existing [B]uffers" })

vim.keymap.set("n", "<leader>fp", ":lua require'telescope'.extensions.project.project{}<CR>", { desc = "[F]ind [P]roject" })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, { desc = "[F]ind in [C]urrent buffer" })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set("n", "<leader>f/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[F]ind [/] in Open Files" })

vim.keymap.set("n", "<leader>fa", function()
	builtin.find_files({
		follow = true,
		no_ignore = true,
		hidden = true,
		prompt_title = "Find All Files",
	})
end, { desc = "[F]ind [A]ll files" })

-- conform
vim.keymap.set("n", "<leader>fm", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "[F]or[M]atting" })

vim.keymap.set("n", "<leader>fd", "<Cmd>DiffFormat<CR>", { desc = "[F]ormat [D]iff" })

-- lspconfig
local map_lsp = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = "LSP: " .. desc })
end

map_lsp("K", vim.lsp.buf.hover, "Hover")
map_lsp("<leader>ls", vim.lsp.buf.signature_help, "[L]SP [S]ignature help")
map_lsp("<leader>lf", function()
	vim.diagnostic.open_float({ border = "rounded" })
end, "[L]SP [F]loat diagnostics")
map_lsp("[d", function()
	vim.diagnostic.jump({ count = -1, float = { border = "rounded" } })
end, "Previous [D]iagnostic")
map_lsp("]d", function()
	vim.diagnostic.jump({ count = 1, float = { border = "rounded" } })
end, "Next [D]iagnostic")
-- map_lsp("<leader>q", vim.diagnostic.setloclist, "[Q]uickfix diagnostics list")
map_lsp("<leader>q", require("telescope.builtin").diagnostics, "[Q]uickfix diagnostics list")
map_lsp("<leader>wa", vim.lsp.buf.add_workspace_folder, "LSP [W]orkspace [A]dd folder")
map_lsp("<leader>wr", vim.lsp.buf.remove_workspace_folder, "LSP [W]orkspace [R]emove folder")
map_lsp("<leader>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, "LSP [W]orkspace [L]ist folders")
map_lsp("gd", function()
	vim.lsp.buf.definition({ reuse_win = true })
end, "[G]oto [D]efinition")
map_lsp("gr", function()
	require("telescope.builtin").lsp_references({ reuse_win = true })
end, "[G]oto [R]eferences")
map_lsp("gI", function()
	vim.lsp.buf.implementation({ reuse_win = true })
end, "[G]oto [I]mplementation")
map_lsp("gD", function()
	vim.lsp.buf.declaration({ reuse_win = true })
end, "[G]oto [D]eclaration")
map_lsp("gt", function()
	vim.lsp.buf.type_definition({ reuse_win = true })
end, "[G]oto [T]ype definition")
map_lsp("<leader>fs", require("telescope.builtin").lsp_document_symbols, "[F]ind document [S]ymbols")
map_lsp("<leader>fws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[F]ind [W]orkspace [S]ymbols")
map_lsp("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
map_lsp("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
map_lsp("<leader>ci", require("telescope.builtin").lsp_incoming_calls, "[C]alls [I]ncoming")
map_lsp("<leader>co", require("telescope.builtin").lsp_outgoing_calls, "[C]alls [O]utgoing")

--toggleterm mappings
vim.keymap.set({ "t", "n" }, "<A-i>", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle floating term" })
vim.keymap.set({ "t", "n" }, "<A-v>", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Toggle floating term" })
vim.keymap.set({ "t", "n" }, "<A-h>", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Toggle floating term" })

-- nvterm terminal
-- vim.keymap.set("t", "<A-i>", function()
-- 	require("nvterm.terminal").toggle("float")
-- end, { desc = "Toggle floating term" })
-- vim.keymap.set("n", "<A-i>", function()
-- 	require("nvterm.terminal").toggle("float")
-- end, { desc = "Toggle floating term" })
--
-- vim.keymap.set("t", "<A-h>", function()
-- 	require("nvterm.terminal").toggle("horizontal")
-- end, { desc = "Toggle horizontal term" })
-- vim.keymap.set("n", "<A-h>", function()
-- 	require("nvterm.terminal").toggle("horizontal")
-- end, { desc = "Toggle horizontal term" })
--
-- vim.keymap.set("t", "<A-v>", function()
-- 	require("nvterm.terminal").toggle("vertical")
-- end, { desc = "Toggle vertical term" })
-- vim.keymap.set("n", "<A-v>", function()
-- 	require("nvterm.terminal").toggle("vertical")
-- end, { desc = "Toggle vertical term" })

-- vim.keymap.set("n", "<leader>h", function()
-- 	require("nvterm.terminal").new("horizontal")
-- end, { desc = "New horizontal term" })
-- vim.keymap.set("n", "<leader>v", function()
-- 	require("nvterm.terminal").new("vertical")
-- end, { desc = "New vertical term" })

-- Comment
vim.keymap.set("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })
vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle comment" })

-- from my old config
-- Up and down while the cursor is in the center
vim.keymap.set("n", "<C-D>", "<C-D>zz", { silent = true, noremap = true })
vim.keymap.set("n", "<C-U>", "<C-U>zz", { silent = true, noremap = true })

-- ThePrimeagen remaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<C-g>", "<cmd>silent !tmux neww goto<CR>")
-- love <leader> much more than ctrl ! :)
vim.keymap.set("n", "<leader>ww", "<C-w>w")

-- bufferline
vim.keymap.set("n", "<tab>", "<Cmd>BufferNext<Cr>", { desc = "Next Buffer", remap = false })
vim.keymap.set("n", "<S-tab>", "<Cmd>BufferPrevious<Cr>", { desc = "Previous Buffer", remap = false })
vim.keymap.set("n", "<leader>x", "<Cmd>BufferClose<Cr>", { desc = "Close Buffer", remap = false })
vim.keymap.set("n", "<C-x>", "<Cmd>BufferCloseAllButCurrent<Cr>", { desc = "Close All But Current", remap = false })

-- refactoring
vim.keymap.set("x", "<leader>re", ":Refactor extract ")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")
vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")
vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")
vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")

-- harpoon
vim.keymap.set("n", "<leader>ha", function()
	require("harpoon"):list():add()
end, { desc = "Harpoon Add" })
vim.keymap.set("n", "<leader>hd", function()
	require("harpoon"):list():remove()
end, { desc = "Harpoon Remove" })
vim.keymap.set("n", "<leader>hc", function()
	require("harpoon"):list():clear()
end, { desc = "Harpoon Clear" })
vim.keymap.set("n", "<leader>hl", function()
	require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end, { desc = "Harpoon List" })

for i = 1, 9 do
	vim.keymap.set("n", "<leader>h" .. i, function()
		require("harpoon"):list():select(i)
	end)
end

-- Toggle previous & next buffers stored within require('Harpoon') list
vim.keymap.set("n", "<leader>hp", function()
	require("harpoon"):list():prev()
end)
vim.keymap.set("n", "<leader>hn", function()
	require("harpoon"):list():next()
end)

-- molten
vim.keymap.set("n", "<leader>j", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "run operator selection" })
vim.keymap.set("n", "<M-r>", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "run operator selection" })
vim.keymap.set("n", "<leader>jj", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
vim.keymap.set("v", "<leader>j", ":<C-u>MoltenEvaluateVisual<CR>gv", { silent = true, desc = "evaluate visual selection" })
vim.keymap.set("v", "<M-r>", ":<C-u>MoltenEvaluateVisual<CR>gv", { silent = true, desc = "evaluate visual selection" })
vim.keymap.set("n", "<leader>jc", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate cell" })
vim.keymap.set("n", "<leader>jd", ":MoltenDelete<CR>", { noremap = true })
vim.keymap.set("n", "<leader>jo", ":MoltenShowOutput<CR>", { noremap = true })
vim.keymap.set("n", "<leader>jh", ":MoltenHideOutput<CR>", { noremap = true })
vim.keymap.set("n", "<leader>jr", ":MoltenRestart<CR>", { noremap = true })
vim.keymap.set("n", "<leader>ji", ":MoltenInterrupt<CR>", { noremap = true })
vim.keymap.set("n", "<leader>js", ":MoltenSave<CR>", { noremap = true })
vim.keymap.set("n", "<leader>jl", ":MoltenLoad<CR>", { noremap = true })
vim.keymap.set("n", "<leader>jq", ":noautocmd MoltenEnterOutput<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>jx", ":MoltenOpenInBrowser<CR>", { desc = "open output in browser", silent = true })

-- venv-selector
vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "Select virtual environment" })

-- markdown preview
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown preview" })
