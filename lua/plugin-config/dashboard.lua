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
}

dashboard.custom_center = {
    {
        icon = icons.ui.NewFile .. " ",
        desc = "New File                            ",
        shortcut = "SPC f n",
        action = "new",
    },
    {
        icon = icons.ui.Flag .. " ",
        desc = "Projects                            ",
        shortcut = "SPC f p",
        action = "Telescope projects",
    },
    {
        icon = icons.ui.History .. " ",
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

local function custom_footer()
    local msg = icons.git.Octoface .. " geekifan"
    local version = icons.ui.Dashboard .. " " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
    local footer = msg .. " " .. version
    if packer_plugins ~= nil then
        local count = #vim.tbl_keys(packer_plugins)
        local plugin = " " .. count .. " plugins"
        footer = footer .. " " .. plugin
    end
    return {
        "",
        "",
        footer,
    }
end

dashboard.custom_footer = custom_footer

