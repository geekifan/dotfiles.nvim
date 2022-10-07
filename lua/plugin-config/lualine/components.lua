icons = require("icons")
colors = require("plugin-config.lualine.colors")
conditions = require("plugin-config.lualine.conditions")

local separator = icons.ui.LineMiddle
local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
        }
    end
end

return {
    mode = {
        -- function()
        --     return " " .. icons.ui.Target .. " " .. mode() .. " "
        -- end,
        "mode",
        icon = icons.ui.Target,
        -- padding = { left = 0, right = 0 },
        color = {},
        cond = nil,
    },
    branch = {
        "b:gitsigns_head",
        icon = icons.git.Branch,
        color = { gui = "bold" },
    },
    filename = {
        "filename",
        color = {},
        cond = nil,
    },
    diff = {
        "diff",
        source = diff_source,
        symbols = {
        added = icons.git.LineAdded .. " ",
        modified = icons.git.LineModified .. " ",
        removed = icons.git.LineRemoved .. " ",
        },
        padding = { left = 2, right = 1 },
        diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.yellow },
        removed = { fg = colors.red },
        },
        cond = nil,
    },
    python_env = {
        function()
        local utils = require "plugin-config.lualine.utils"
        if vim.bo.filetype == "python" then
            local venv = os.getenv "CONDA_DEFAULT_ENV" or os.getenv "VIRTUAL_ENV"
            if venv then
            local icons = require "nvim-web-devicons"
            local py_icon, _ = icons.get_icon ".py"
            return string.format(" " .. py_icon .. " (%s)", utils.env_cleanup(venv))
            end
        end
        return ""
        end,
        color = { fg = colors.green },
        cond = conditions.hide_in_width,
    },
    diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
        error = icons.diagnostics.BoldError .. " ",
        warn = icons.diagnostics.BoldWarning .. " ",
        info = icons.diagnostics.BoldInformation .. " ",
        hint = icons.diagnostics.BoldHint .. " ",
        },
        -- cond = conditions.hide_in_width,
    },
    -- treesitter = {
    --     function()
    --     return lvim.icons.ui.Tree
    --     end,
    --     color = function()
    --     local buf = vim.api.nvim_get_current_buf()
    --     local ts = vim.treesitter.highlighter.active[buf]
    --     return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
    --     end,
    --     cond = conditions.hide_in_width,
    -- },
    -- lsp = {
    --     function(msg)
    --     msg = msg or "LS Inactive"
    --     local buf_clients = vim.lsp.buf_get_clients()
    --     if next(buf_clients) == nil then
    --         -- TODO: clean up this if statement
    --         if type(msg) == "boolean" or #msg == 0 then
    --         return "LS Inactive"
    --         end
    --         return msg
    --     end
    --     local buf_ft = vim.bo.filetype
    --     local buf_client_names = {}
    --
    --     -- add client
    --     for _, client in pairs(buf_clients) do
    --         if client.name ~= "null-ls" then
    --         table.insert(buf_client_names, client.name)
    --         end
    --     end
    --
    --     -- add formatter
    --     local formatters = require "lvim.lsp.null-ls.formatters"
    --     local supported_formatters = formatters.list_registered(buf_ft)
    --     vim.list_extend(buf_client_names, supported_formatters)
    --
    --     -- add linter
    --     local linters = require "lvim.lsp.null-ls.linters"
    --     local supported_linters = linters.list_registered(buf_ft)
    --     vim.list_extend(buf_client_names, supported_linters)
    --
    --     local unique_client_names = vim.fn.uniq(buf_client_names)
    --     return "[" .. table.concat(unique_client_names, ", ") .. "]"
    --     end,
    --     separator = separator,
    --     color = { gui = "bold" },
    --     cond = conditions.hide_in_width,
    -- },
    location = { "location", color = location_color },
    progress = {
        "progress",
        fmt = function()
        return "%P/%L"
        end,
        color = {},
    },

    spaces = {
        function()
        local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
        return icons.ui.Tab .. " " .. shiftwidth
        end,
        separator = separator,
        padding = 1,
    },
    encoding = {
        "o:encoding",
        fmt = string.upper,
        color = {},
        cond = conditions.hide_in_width,
    },
    filetype = { "filetype", cond = nil, padding = { left = 1, right = 1 } },
    -- scrollbar = {
    --     function()
    --     local current_line = vim.fn.line "."
    --     local total_lines = vim.fn.line "$"
    --     local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    --     local line_ratio = current_line / total_lines
    --     local index = math.ceil(line_ratio * #chars)
    --     return chars[index]
    --     end,
    --     padding = { left = 0, right = 0 },
    --     color = "SLProgress",
    --     cond = nil,
    -- },
}
