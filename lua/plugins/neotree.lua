local icons = require("config.icons")

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
    filesystem = {
        use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
    },
    init = function()
        vim.loop.new_timer():start(1000, 1000, vim.schedule_wrap(function()
            local manager = require("neo-tree.sources.manager")
            local state   = manager.get_state("filesystem")
            if not state or not state.winid then
                return
            end
            local bufnr = vim.api.nvim_win_get_buf(state.winid)
            local source_status, source_name = pcall(vim.api.nvim_buf_get_var, bufnr, "neo_tree_source")
            if not source_status then
                return
            end
            -- refresh the filesystem if the current source is filesystem
            if state
               and state.winid
               and vim.api.nvim_win_is_valid(state.winid)
               and source_name == "filesystem"
            then
                require("neo-tree.sources.filesystem.commands").refresh(state)
            end
        end))
    end,
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
                ["S"] = "", -- unset S key to avoid conflict with flash.nvim
                ["s"] = "", -- unset s key to avoid conflict with flash.nvim
            },
        },
        default_component_configs = {
            git_status = {
                symbols = {
                  -- Change type
                  added     = icons.git.FileAdded, -- NOTE: you can set any of these to an empty string to not show them
                  deleted   = icons.git.FileDeleted,
                  modified  = icons.git.FileModified,
                  renamed   = icons.git.FileRenamed,
                  -- Status type
                  untracked = icons.git.FileUntracked,
                  ignored   = icons.git.FileIgnored,
                  unstaged  = icons.git.FileUnstaged,
                  staged    = icons.git.FileStaged,
                  conflict  = icons.git.FileConflict,
                },
                align = "right",
              },
        },
    },
    -- config = function()
    --     vim.cmd("Neotree document_symbols")
    -- end
}