local status, autosave = pcall(require, "auto-save")
if not status then
    vim.notify("auto-save not found")
    return
end

autosave.setup()

