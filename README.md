# My Neovim config 

This is my personal configuration of neovim editor written in lua. 
The configuration started from [kickstart](https://github.com/nvim-lua/kickstart.nvim) config but expanded real fast ...  

# Features
Some features include
- Configured LSP (autocomplete)/linting/formatting/debugging for Python, C++ and others.
- Copilot and Copilot-chat support.
- Git support using [fugitive](https://github.com/tpope/vim-fugitive) for actions, and [gitsigns](https://github.com/lewis6991/gitsigns.nvim) for in-buffer signs.
- Ui components: file explorer [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua), tabline [barbar](https://github.com/romgrk/barbar.nvim) and statusline [lualine](https://github.com/nvim-lualine/lualine.nvim)
- Embedded terminal [nvterm](https://github.com/zbirenbaum/nvterm)
- Colorscheme: [tokyonight](https://github.com/folke/tokyonight.nvim)
- And others ...

# Mapping 
All mappings can be found in [lua/mappings.lua](lua/mappings.lua)

# Plguins
Full list of plugins can be found in [lua/plugins/](lua/plugins) directory, each plugin has its own file. 

# Installation 

- First install [neovim](https://github.com/neovim/neovim?tab=readme-ov-file#install-from-package).
- Backup your previous configuration: 
```bash
mv ~/.config/nvim ~/.config/nvim.backup
```
- Download this configurations
```bash
git clone https://github.com/ZeinBarhoum/nvim_config ~/.config/nvim 
```
