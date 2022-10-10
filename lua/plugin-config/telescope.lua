local status, telescope = pcall(require, "telescope")
if not status then
    vim.notify("telescope not found")
    return
end

local icons = require("icons")

telescope.setup({
    defaults = {
        prompt_prefix = " " .. icons.ui.Search .. " ",
        entry_prefix = "   ",
        selection_caret = "   ",
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = {
                prompt_position = "top",
            }
        }
    }
})
telescope.load_extension("projects")

