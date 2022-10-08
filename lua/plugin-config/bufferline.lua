local status, bufferline = pcall(require, "bufferline")
if not status then
    vim.notify("bufferline not found")
    return
end

local icons = require("icons")

bufferline.setup {
    options = {
        -- use nvim lsp
        diagnostics = "coc",
        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
        --     local icon = level:match("error") and icons.diagnostics.BoldError or icons.diagnostics.BoldWarning
        --     return " " .. icon .. count
        -- end,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
                local sym = ""
                if e == "error" then
                    sym = icons.diagnostics.BoldError .. " "
                elseif e == "warning" then
                    sym = icons.diagnostics.BoldWarning .. " "
                elseif e == "info" then
                    sym = icons.diagnostics.BoldInformation .. " "
                else
                    sym = icons.diagnostics.BoldHint .. " "
                end
                s = s .. n .. sym
            end
            return s
        end,
        -- give space to nvimtree
        offsets = {{
            filetype = "NvimTree",
            text = "File Explorer",
            -- highlight = "Directory",
            text_align = "center"
        }},
        -- separator_style = "thick"
    }
}
