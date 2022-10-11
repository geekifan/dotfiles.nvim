local status, onedark = pcall(require, "onedark")
if not status then
    vim.notify("onedark not found")
    return
end

onedark.setup({
    colors = {
        bright_yellow = "#eeeeb3"
    },
    highlights = {
        TelescopeBorder = {fg = "$fg"},
        TelescopePromptPrefix = {fg = "$grey"},
        TelescopePromptBorder = {fg = "$grey"},
        TelescopePreviewBorder = {fg = "$grey"},
        TelescopeResultsBorder = {fg = "$grey"},
        CocHintSign = {fg = "$bright_yellow"},
        DiagnosticHint = {fg = "$bright_yellow"},
        DiagnosticVirtualTextHint = {fg = "$bright_yellow"},
        DiagnosticUnderlineHint = {sp = "$bright_yellow"},
    }
})

onedark.load()
