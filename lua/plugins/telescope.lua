local icons = require("config.icons")

return {
    {
        "nvim-telescope/telescope.nvim", tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim"  },
        opts = {
            defaults = {
                prompt_prefix = " " .. icons.ui.Search .. " ",
                entry_prefix = "   ",
                selection_caret = " " .. icons.ui.Forward .. " ",
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                    }
                }
            }
        },
    },
    {
        "nvim-telescope/telescope-project.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("telescope").load_extension("project")
        end
    }
}
