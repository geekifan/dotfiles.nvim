local status, dashboard = pcall(require, "dashboard")
if not status then
    vim.notify("dashboard not found")
    return
end

icons = require("icons")

dashboard.hide_tabline = false

dashboard.custom_header = {
    [[]],
    [[]],
    [[]],
    [[]],
    [[]],
    [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
    [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
    [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
    [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
    [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
    [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
    [[                                                   ]],
    [[]],
    [[]],
    [[]],
    [[]],
    [[]],
}

dashboard.custom_center = {
    {
        icon = icons.ui.Flag .. " ",
        desc = "Projects                            ",
        shortcut = "SPC f p",
        action = "Telescope projects",
    },
    {
        icon = icons.ui.Files .. " ",
        desc = "Recent files                        ",
        shortcut = "SPC f r",
        action = "Telescope oldfiles",
    },
    {
        icon = icons.ui.FindFile .. " ",
        desc = "Find file                           ",
        shortcut = "SPC f f",
        action = "Telescope find_files",
    },
    {
        icon = icons.ui.Tree .. " ",
        desc = "File Explorer                       ",
        shortcut = "SPC f e",
        action = "NvimTreeToggle",
    }
}

-- dashboard.custom_footer = {
--     "",
--     "",
--     "Have fun with neovim!",
-- }

