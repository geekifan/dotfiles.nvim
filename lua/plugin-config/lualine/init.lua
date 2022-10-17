local status, lualine = pcall(require, "lualine")
if not status then
    vim.notify("lualine not found")
    return
end

local components = require("plugin-config.lualine.components")

lualine.setup({
    options = {
        disabled_filetypes = {"NvimTree", "Packer", "vista", "vista_markdown"},
        theme = "onedark",
        component_separators = {
            left = "",
            right = "",
        },
        section_separators = {
            left = "",
            right = "",
        },
    },
    sections = {
        lualine_a = {
            components.mode,
        },
        lualine_b = {
            components.branch,
        },
        lualine_c = {
            components.diff,
            components.python_env,
        },
        lualine_x = {
            components.diagnostics,
            components.encoding,
            -- components.lsp,
            -- components.spaces,
            components.filetype,
        },
        lualine_y = {
            components.location
        },
        lualine_z = {
            components.progress,
        },
    },
    inactive_sections = {
        lualine_a = {
            components.mode,
        },
        lualine_b = {
            components.branch,
        },
        lualine_c = {
            components.diff,
            components.python_env,
        },
        lualine_x = {
            components.diagnostics,
            components.encoding,
            -- components.lsp,
            -- components.spaces,
            components.filetype,
        },
        lualine_y = {
            components.location
        },
        lualine_z = {
            components.progress,
        },
    }
})
