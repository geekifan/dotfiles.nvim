require("basic")
require("keybindings")
require("plugins")
require("github-theme").setup({
    theme_style = "dimmed",
    hide_inactive_statusline = false,
})
require("plugin-config.nvim-tree")
require("plugin-config.bufferline")
require("plugin-config.nvim-treesitter")
require("plugin-config.nvim-autopairs")
require("plugin-config.lualine")
require("plugin-config.comment")
require("plugin-config.dashboard")
require("plugin-config.telescope")
require("plugin-config.which-key")
require("plugin-config.coc")
require("plugin-config.nvim-notify")

