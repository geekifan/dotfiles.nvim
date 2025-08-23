return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    opts = {
        options = {
            numbers = function(opts)
                return string.format('%s', opts.raise(opts.ordinal))
            end,
            -- 在顶部左侧给 Neo Tree 留空间
            offsets = {{
                filetype = "neo-tree",
                text = "Sidebar",
                text_align = "center"
            }},
            close_command = function(bufnr)
                Snacks.bufdelete(bufnr)
            end,
        },
    }
}
