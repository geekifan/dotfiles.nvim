local status, project = pcall(require, "project_nvim")
if not status then
    vim.notify("project not found")
    return
end

project.setup()
