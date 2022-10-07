local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
    vim.notify("nvim-tree not found")
    return
end

local keys = require('keybindings').nvimTreeList

nvim_tree.setup({
    view = {
        mappings = {
            custom_only = true,
            list = keys,
        }
    },
})

-- auto close
vim.api.nvim_create_autocmd('BufEnter', {
    command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
    nested = true,
})
