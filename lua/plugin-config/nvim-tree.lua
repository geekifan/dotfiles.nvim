local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
    vim.notify("nvim-tree not found")
    return
end

local keys = require('keybindings').nvimTreeList
local icons = require('icons')

nvim_tree.setup({
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true,
    },
    view = {
        mappings = {
            custom_only = true,
            list = keys,
        },
    },
    renderer = {
        highlight_git = true,
        indent_markers = {
            enable = true,
        },
        icons = {
            show = {
                folder_arrow = false,
            },
            glyphs = {
                git = {
                    unstaged = icons.git.FileUnstaged,
                    staged = icons.git.FileStaged,
                    unmerged = icons.git.FileUnmerged,
                    renamed = icons.git.FileRenamed,
                    untracked = icons.git.FileUntracked,
                    deleted = icons.git.FileDeleted,
                    ignored = icons.git.FileIgnored,
                }
            },
        },
    },
    diagnostics = {
        enable = true,
    },
    git = {
        ignore = false,
    },
})

-- auto close
vim.api.nvim_create_autocmd('BufEnter', {
    command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
    nested = true,
})
