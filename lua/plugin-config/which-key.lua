local status, wk = pcall(require, "which-key")
if not status then
    vim.notify("which-key not found")
    return
end

local icons = require("icons")

local keys = require("keybindings").whichKeyList

wk.setup({
    icons = {
        breadcrumb = icons.ui.DoubleChevronRight,
        separator = " " .. icons.ui.BoldArrowRight .. " ",
    },
    window = {
        border = "single",
        position = "bottom",
    },
})
wk.register(keys)
