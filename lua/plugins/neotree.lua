return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    keys = {
        {
          "<leader>e",
          function()
            require("neo-tree.command").execute({
              toggle = true,
              source = "filesystem",
              position = "left",
            })
          end,
          desc = "Explorer",
        },
    },
    opts = {
        sources = {
            "filesystem",
            "buffers",
            "git_status",
            "document_symbols",
        },
        -- 在窗口的标题栏显示文件浏览器、缓冲区、git状态
        source_selector = {
            winbar = true,
            statusline = false,
            sources = {
                {
                    source = "filesystem",                                -- string
                    display_name = " 󰉓 Files "                            -- string | nil
                },
                {
                    source = "buffers",                                   -- string
                    display_name = " 󰈚 Buffers "                          -- string | nil
                },
                {
                    source = "git_status",                                -- string
                    display_name = " 󰊢 Git "                              -- string | nil
                },
                {
                    source = "document_symbols",                                -- string
                    display_name = "  Symbols "                              -- string | nil
                }
            }
        },
        window = {
            mappings = {
                -- 在打开窗口时，使用快捷键切换到文件浏览器、缓冲区、git状态
                ['1'] = function() vim.api.nvim_exec('Neotree focus filesystem left', true) end,
                ['2'] = function() vim.api.nvim_exec('Neotree focus buffers left', true) end,
                ['3'] = function() vim.api.nvim_exec('Neotree focus git_status left', true) end,
                ['4'] = function() vim.api.nvim_exec('Neotree focus document_symbols left', true) end,
                ["P"] = { "toggle_preview", config = { use_float = false } },
            },
        },
    },
    -- config = function()
    --     vim.cmd("Neotree document_symbols")
    -- end
}