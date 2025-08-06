return {
    { "EdenEast/nightfox.nvim" },
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
    {
        "sphamba/smear-cursor.nvim",
      
        opts = {
          -- Smear cursor when switching buffers or windows.
          smear_between_buffers = true,
      
          -- Smear cursor when moving within line or to neighbor lines.
          -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
          smear_between_neighbor_lines = true,
      
          -- Draw the smear in buffer space instead of screen space when scrolling
          scroll_buffer_space = true,
      
          -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
          -- Smears will blend better on all backgrounds.
          legacy_computing_symbols_support = false,
      
          -- Smear cursor in insert mode.
          -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
          smear_insert_mode = true,
        },
    },
    { "karb94/neoscroll.nvim"},
}   