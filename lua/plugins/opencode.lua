local port = 48291

return {
    'NickvanDyke/opencode.nvim',
    dependencies = { 'folke/snacks.nvim', },
    ---@type opencode.Config
    opts = {
        -- Your configuration, if any
        port = port,
    },
    -- stylua: ignore
    keys = require('config.keybindings').opencode,
    init = function()
        vim.api.nvim_create_user_command("OpenCode", function()
            require("opencode").toggle({ port = port })
        end, {})
    end,
}