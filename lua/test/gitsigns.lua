local status, gitsigns = pcall(require, "gitsigns")
if not status then
    vim.notify("gitsigns not found")
    return
end

gitsigns.setup({
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 0,
    },
    sign_priority = 100,
})
