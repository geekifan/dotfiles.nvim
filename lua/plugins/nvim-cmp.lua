return {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
    },
    opts = function()
        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
        local cmp = require("cmp")
        local icons = require("config.icons")
        local defaults = require("cmp.config.default")()
        local auto_select = true -- 补全菜单弹出时默认选中第一项。
        return {
            -- menu：显示补全菜单
            -- menuone：即使只有一个补全项也显示菜单
            -- noinsert：不自动插入文本
            -- noselect：不自动选中任何项（由 auto_select 控制是否添加）
            completion = {
                completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
            },
            preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), -- 向下选择
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), -- 向上选择
                ["<C-Space>"] = cmp.mapping.complete(),                                             -- 手动触发补全
                ["<CR>"] = cmp.mapping.confirm({                                                    -- 确认补全
                    select = auto_select, -- true 表示“无显式选择时也确认第一项”
                    behavior = cmp.ConfirmBehavior.Insert,
                }),
                ["<C-CR>"] = function(fallback)                                                     -- 当按下 Ctrl+回车时，放弃补全
                    cmp.abort()
                    fallback()
                end,
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
                -- { name = 'vsnip' }, -- For vsnip users.
                -- { name = 'luasnip' }, -- For luasnip users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
            }),
            formatting = {
                format = function(entry, item)
                    if icons[item.kind] then
                        item.kind = icons[item.kind] .. item.kind -- 添加图标前缀
                    end

                    local widths = {
                        abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
                        menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
                    }

                    for key, width in pairs(widths) do
                        if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                            item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
                        end
                    end

                    return item
                end,
            },
        }
    end,
}
