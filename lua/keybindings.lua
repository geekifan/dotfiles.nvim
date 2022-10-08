-- map(mode, key, bind_key, opt)
-- modes:
--   normal_mode = "n"
--   insert_mode = "i"
--   visual_mode = "v"
--   visual_block_mode = "x"
--   term_mode = "t"
--   command_mode = "c"


-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
local opt = {
    noremap = true,
    silent = true,
}

-- quick move
map("n", "<C-u>", "8k", opt)
map("n", "<C-d>", "8j", opt)
map("n", "<C-j>", "5j", opt)
map("n", "<C-k>", "5k", opt)

-- esc
map("i", "jj", "<esc>", opt)

-- select all
map("n", "<C-a>", "GVgg", opt)

-- window move
map("n", "<C-A-h>", "<C-w>h", opt)
map("n", "<C-A-j>", "<C-w>j", opt)
map("n", "<C-A-k>", "<C-w>k", opt)
map("n", "<C-A-l>", "<C-w>l", opt)

-- vertical resize
map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-Right>", ":vertical resize +2<CR>", opt)

-- horizontal resize
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)

-- bufferline bindings
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)

-- toggleterm bindings
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)


local pluginKeys = {}

pluginKeys.nvimTreeList = {
    { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit"},
    -- open files in vsplit mode
    { key = "v", action = "vsplit" },
    -- open files in split mode
    { key = "h", action = "split" },
    -- toggle ignored files (e.g. node_modules)
    { key = "i", action = "toggle_ignored" },
    -- hide (dotfiles)
    { key = ".", action = "toggle_dotfiles" },
    { key = "R", action = "refresh" },
    -- file operations
    { key = "a", action = "create" },
    { key = "d", action = "remove" },
    { key = "r", action = "rename" },
    { key = "x", action = "cut" },
    { key = "c", action = "copy" },
    { key = "p", action = "paste" },
    { key = "y", action = "copy_name" },
    { key = "Y", action = "copy_path" },
    { key = "gy", action = "copy_absolute_path" },
    { key = "I", action = "toggle_file_info" },
    { key = "n", action = "tabnew" },
    -- cd to the folder
    { key = { "]" }, action = "cd" },
    -- cd to the parent folder
    { key = { "[" }, action = "dir_up" },
}

pluginKeys.whichKeyList = {
    ["<leader>f"] = { name =  "File" },
    ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
    ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    ["<leader>fe"] = { "<cmd>NvimTreeToggle<cr>", "Toggle File Explorer" },
    ["<leader>fg"] = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
    ["<leader>fp"] = { "<cmd>Telescope projects", "Projects"},

    ["<leader>b"] = { name = "Buffer" },
    ["<leader>bs"] = { "<cmd>Telescope buffers<cr>", "Show Buffers" },
    ["<leader>bc"] = { "<cmd>Bdelete<cr>", "Close Buffer" },

    ["<leader>c"] = { name = "Coc"},
    ["<leader>cm"] = { "<cmd>CocList marketplace<cr>", "Marketplace"},
    ["<leader>ce"] = { "<cmd>CocList extensions<cr>", "Installed Extensions"},
    ["<leader>cc"] = { "<cmd>CocConfig<cr>", "Open Coc Config"},

    ["<leader>d"] = {"<cmd>Dashboard<cr>", "Dashboard"},
}

return pluginKeys
