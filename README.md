# dotfiles.nvim

## Introduction

This is my neovim configuration written in lua. I use [packer.nvim](https://github.com/wbthomason/packer.nvim) as my plugin manager.

## Plugin List

My plugin list:

|     Name    | Introduction |
|     ----    |     ----     |
| [packer.nvim](https://github.com/wbthomason/packer.nvim) | Plugin manager |
| [navarasu/onedark.nvim](https://github.com/navarasu/onedark.nvim)| Onedark color theme |
| [famiu/bufdelete.nvim](https://github.com/famiu/bufdelete.nvim) | Provide commands to delete buffers without messing up window layout |
| [kyazdani42/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua) | File explorer |
| [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Beautiful tabs |
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Treesitter support for neoim |
| [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Automatically pair brackets |
| [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Powerful statusline |
| [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim) | Toggle comments |
| [glepnir/dashboard-nvim](https://github.com/glepnir/dashboard-nvim) | Startup screen |
| [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | File finder |
| [folke/which-key.nvim](https://github.com/folke/which-key.nvim) | Key mapping hinter |
| [neoclide/coc.nvim](https://github.com/neoclide/coc.nvim) | Extension manager like VSCode (usually used for LSP installation) |
| [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify) | Beautiful neovim notification window |
| [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git integrations |
| [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Terminal support |
| [ahmedkhalf/project.nvim](https://github.com/ahmedkhalf/project.nvim) | Project manager |
| [tpope/vim-surround](https://github.com/tpope/vim-surround) | Surroundings support |


## Getting Started

This section should guide you to run your neovim using this configuration.

[Neovim 0.8.0](https://github.com/neovim/neovim/releases/tag/v0.8.0) is highly recomended for this configuration to work.


### Required Dependencies

- [node.js](https://nodejs.org/en/) >= 14.14 (required by [neoclide/coc.nvim](https://github.com/neoclide/coc.nvim) )
- [ripgrep](https://github.com/BurntSushi/ripgrep) (required by [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)) 
- [fd](https://github.com/sharkdp/fd) (required by [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)) 

### Installation

Clone this repository to `~/.config/nvim` (create one if not existed):

```
git clone https://github.com/geekifan/dotfiles.nvim.git ~/.config/nvim
```

Then start neovim and the package manager `Packer.nvim` should bootstrap.

Restart neovim after `Packer.nvim` bootstrapping and enter command `:PackerSync` to download all the plugins. There may be `nvim-treesitter` failures due to `TSUpdate`. Just ignore it.

Restart neovim again and everything is ok.

### Usage

Install treesitter:

`:TSInstall the-language-you-want-to-install`

**I recommend you to run `:TSInstall all` to get all language treesitters.**

Install coc marketplace:

`:CocInstall coc-marketplace`

