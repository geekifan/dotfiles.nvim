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
        -- 在窗口的标题栏显示文件浏览器、缓冲区、git状态
        source_selector = {
            winbar = true,
            statusline = false
        },
        window = {
            mappings = {
                -- 在打开窗口时，使用快捷键切换到文件浏览器、缓冲区、git状态
                ['e'] = function() vim.api.nvim_exec('Neotree focus filesystem left', true) end,
                ['b'] = function() vim.api.nvim_exec('Neotree focus buffers left', true) end,
                ['g'] = function() vim.api.nvim_exec('Neotree focus git_status left', true) end,
                ["P"] = { "toggle_preview", config = { use_float = false } },
            },
        },
    }
}