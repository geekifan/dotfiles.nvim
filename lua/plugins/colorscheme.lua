return {
    { "EdenEast/nightfox.nvim" },
    { "folke/tokyonight.nvim" },
    { "projekt0n/github-nvim-theme" },
    {
        "catppuccin/nvim",
        init = function()
            vim.cmd("colorscheme catppuccin-frappe")
        end,
    },
    { "sainnhe/everforest" },
}
