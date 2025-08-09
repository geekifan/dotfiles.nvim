return {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    opts = {
        current_line_blame = true,
        current_line_blame_opts = {
            delay = 0,
        },
        sign_priority = 100,
    }
}