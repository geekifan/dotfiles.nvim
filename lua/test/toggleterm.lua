local status, toggleterm = pcall(require, "toggleterm")
if not status then
    vim.notify("toggleterm not found")
    return
end

toggleterm.setup({
    open_mapping = [[<C-\>]],
    insert_mappings = true,
    terminal_mappings = true,
    direction = "horizontal",
})

