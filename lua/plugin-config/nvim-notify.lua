local status, notify = pcall(require, "notify")
if not status then
    vim.notify("notify not found")
    return
end

notify.setup({
    stages = "fade"
})

vim.notify = notify

