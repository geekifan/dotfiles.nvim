local status, telescope = pcall(require, "telescope")
if not status then
    vim.notify("telescope not found")
    return
end

telescope.setup()
telescope.load_extension("projects")

