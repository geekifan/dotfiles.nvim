return {
    'petertriho/nvim-scrollbar',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'kevinhwang91/nvim-hlslens',
    },
    opts = {
        handlers = {
            gitsigns = true,
            search = true,
        },
    },
}