-- Packer bootstrap
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("packer.nvim not found")
    return
end


packer.startup(function()
    -- Packer can manage itself
    use "wbthomason/packer.nvim"
    use "projekt0n/github-nvim-theme"
    use {"famiu/bufdelete.nvim", commit = "46255e4"} --use old version for neovim 7.2
    use {"kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons"}
    use {"akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons"}
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use "windwp/nvim-autopairs"
    use {"nvim-lualine/lualine.nvim", requires = "kyazdani42/nvim-web-devicons"}
    use "numToStr/Comment.nvim" 
    use "glepnir/dashboard-nvim"
    use {"nvim-telescope/telescope.nvim", tag = "0.1.0", requires = "nvim-lua/plenary.nvim"}
    use "folke/which-key.nvim"
    use {"neoclide/coc.nvim", branch = "release"}
    use "rcarriga/nvim-notify"
    use "lewis6991/gitsigns.nvim"
    use {"akinsho/toggleterm.nvim", tag = "*"}
end)
