local status, comment = pcall(require, "Comment")
if not status then
    vim.notify("comment not found")
    return
end

comment.setup()

