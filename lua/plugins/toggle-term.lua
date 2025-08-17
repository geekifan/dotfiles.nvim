return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        open_mapping = [[<leader>\]],
        insert_mappings = true,
        terminal_mappings = true,
        direction = "float",
        float_opts = {
            border = "curved", -- 可选：shadow, single, double, curved
        },
    },
}