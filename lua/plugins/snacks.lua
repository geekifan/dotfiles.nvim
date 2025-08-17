return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    init = function()
        require("snacks").dim.enable()
    end,
    ---@type snacks.Config
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = {},
        image = {},
        indent = {},
        dim = {},
        scroll = {},
        notifier = {},
        words = {},
        picker = {},
        bufdelete = {},
        dashboard = {
            enabled = true,
            sections = {
                { section = "header" },
                { section = "keys", gap = 1, padding = 1 },
                { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", limit=8, indent = 2, padding = 1 },
                { pane = 2, icon = " ", title = "Projects", section = "projects", limit=8, indent = 2, padding = 1 },
                {
                    pane = 2,
                    icon = " ",
                    title = "Git Status",
                    section = "terminal",
                    enabled = function()
                        return Snacks.git.get_root() ~= nil
                    end,
                    cmd = "git status --short --branch --renames",
                    height = 5,
                    padding = 1,
                    ttl = 5 * 60,
                    indent = 3,
                },
                { section = "startup" },
            },
        },
    },
    keys = require("config.keybindings").snacks
}