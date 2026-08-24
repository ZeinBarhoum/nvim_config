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

# Tips from experience (Checked on Ubuntu 22.04)
- [x] Problem: `[ERROR]: Node.js version 20 or newer` or `[ERROR]: node.js is not installed or not in PATH`
- Solution: Using Nodesource, do `curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash - ` followed by `sudo apt install nodejs`

- [x] Problem: `tree-sitter CLI not found`
- Solution: First install npm `sudo apt install npm`, then install tree-sitter globally using `npm`: `npm install -g tree-sitter-cli`

- [x] Problem: A lot of `<blabla> : failed to install`
- Solution: Install python3-venv `sudo apt install python3-venv`

- [X] Problem: when opening telescopt grep you get `[telescope] ^I...share/ ...` and so on
- Solution: Install ripgrep `sudo apt install ripgrep`

- [X] Problem: Icons are not displayed correctly
- Solution: Set the font in you terminal to a nerd font, you can download one from [here](https://www.nerdfonts.com/) and follow [these instructions ](https://askubuntu.com/a/3701)

- [X] Problem: copied text not shared with system clipboard
- Solution: check `:h clipboard` for instructions on which clipboard functionality providers you should install, for ubuntu on xorg `sudo apt install xsel`
