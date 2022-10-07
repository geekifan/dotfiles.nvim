local status, nvim_autopairs = pcall(require, "nvim-autopairs")
if not status then
    vim.notify("nvim-autopairs not found")
    return
end

nvim_autopairs.setup()
