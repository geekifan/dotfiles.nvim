return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    opts = {
        options = {
            -- 在顶部左侧给 Neo Tree 留空间
            offsets = {{
                filetype = "neo-tree",
                text = "Sidebar",
                text_align = "center"
            }},
        },
    }
}