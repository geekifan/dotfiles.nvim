---@module Foldtext
---Based on https://www.reddit.com/r/neovim/comments/16sqyjz/finally_we_can_have_highlighted_folds/
---Updated with vim.treesitter._fold.foldtext()

local function parse_line(linenr)
    local bufnr = vim.api.nvim_get_current_buf()

    local line = vim.api.nvim_buf_get_lines(bufnr, linenr - 1, linenr, false)[1]
    if not line then
        return nil
    end

    local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
    if not ok then
        return nil
    end

    local query = vim.treesitter.query.get(parser:lang(), "highlights")
    if not query then
        return nil
    end

    local tree = parser:parse({ linenr - 1, linenr })[1]

    local result = {}

    local line_pos = 0

    for id, node, metadata in query:iter_captures(tree:root(), 0, linenr - 1, linenr) do
        local name = query.captures[id]
        local start_row, start_col, end_row, end_col = node:range()

        local priority = tonumber(metadata.priority or vim.highlight.priorities.treesitter)

        if start_row == linenr - 1 and end_row == linenr - 1 then
            -- check for characters ignored by treesitter
            if start_col > line_pos then
                table.insert(result, {
                    line:sub(line_pos + 1, start_col),
                    { { "Folded", priority } },
                    range = { line_pos, start_col },
                })
            end
            line_pos = end_col

            local text = line:sub(start_col + 1, end_col)
            table.insert(result, { text, { { "@" .. name, priority } }, range = { start_col, end_col } })
        end
    end

    local i = 1
    while i <= #result do
        -- find first capture that is not in current range and apply highlights on the way
        local j = i + 1
        while j <= #result and result[j].range[1] >= result[i].range[1] and result[j].range[2] <= result[i].range[2] do
            for k, v in ipairs(result[i][2]) do
                if not vim.tbl_contains(result[j][2], v) then
                    table.insert(result[j][2], k, v)
                end
            end
            j = j + 1
        end

        -- remove the parent capture if it is split into children
        if j > i + 1 then
            table.remove(result, i)
        else
            -- highlights need to be sorted by priority, on equal prio, the deeper nested capture (earlier
            -- in list) should be considered higher prio
            if #result[i][2] > 1 then
                table.sort(result[i][2], function(a, b)
                    return a[2] < b[2]
                end)
            end

            result[i][2] = vim.tbl_map(function(tbl)
                return tbl[1]
            end, result[i][2])
            result[i] = { result[i][1], result[i][2] }

            i = i + 1
        end
    end

    return result
end

function HighlightedFoldtext()
    local result = parse_line(vim.v.foldstart)
    if not result then
        return vim.fn.foldtext()
    end

    local folded = {
        { " ", "FoldedIcon" },
        { "+" .. vim.v.foldend - vim.v.foldstart .. " lines", "FoldedText" },
        { " ", "FoldedIcon" },
    }

    for _, item in ipairs(folded) do
        table.insert(result, item)
    end

    -- local result2 = parse_line(vim.v.foldend)
    -- if result2 and #result2 > 0 then
    --     local first = result2[1]
    --     result2[1] = { vim.trim(first[1]), first[2] }
    --     for _, item in ipairs(result2) do
    --         table.insert(result, item)
    --     end
    -- end

    return result
end

local function set_fold_hl()
    local nf = vim.api.nvim_get_hl(0, { name = "NormalFloat", link = false })
    local comment = vim.api.nvim_get_hl(0, { name = "Comment", link = false })
    vim.api.nvim_set_hl(0, "FoldedIcon", { fg = nf.bg })
    vim.api.nvim_set_hl(0, "FoldedText", { bg = nf.bg, fg = comment.fg, italic = true })
end

set_fold_hl()

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = set_fold_hl,
})

vim.opt.foldtext = [[luaeval('HighlightedFoldtext')()]]

-- WIP: following is from https://github.com/lkhphuc/dotfiles/blob/master/nvim/lua/config/util.lua

M = {}

function M.statuscolumn()
    local win = vim.g.statusline_winid
    local buf = vim.api.nvim_win_get_buf(win)
    local is_file = vim.bo[buf].buftype == ""
    local show_signs = vim.wo[win].signcolumn ~= "no"

    local components = { "", "", "" } -- left, middle, right

    local show_open_folds = vim.g.lazyvim_statuscolumn and vim.g.lazyvim_statuscolumn.folds_open
    local use_githl = vim.g.lazyvim_statuscolumn and vim.g.lazyvim_statuscolumn.folds_githl

    if show_signs then
        local signs = LazyVim.ui.get_signs(buf, vim.v.lnum)

        ---@type Sign?,Sign?,Sign?
        local sign, gitsign, fold, githl
        for _, s in ipairs(signs) do
            if s.name and (s.name:find("GitSign") or s.name:find("MiniDiffSign")) then
                gitsign = s
                if use_githl then
                    githl = s["texthl"]
                end
            else
                sign = s
            end
        end

        vim.api.nvim_win_call(win, function()
            if vim.fn.foldclosed(vim.v.lnum) >= 0 then
                fold = { text = vim.opt.fillchars:get().foldclose or "", texthl = githl or "Folded" }
            elseif
                show_open_folds
                and not LazyVim.ui.skip_foldexpr[buf]
                and tostring(vim.treesitter.foldexpr(vim.v.lnum)):sub(1, 1) == ">"
            then -- fold start
                fold = { text = vim.opt.fillchars:get().foldopen or "", texthl = githl }
            end
        end)

        local mark = LazyVim.ui.get_mark(buf, vim.v.lnum)
        if vim.v.virtnum ~= 0 then
            -- Don't duplicate sign on virtual line
            sign = nil
        else
            sign = mark or fold or sign
        end
        -- except for gitsign's indicator line
        components[2] = LazyVim.ui.icon(sign or gitsign)
    end

    -- Numbers in Neovim are weird
    -- They show when either number or relativenumber is true
    local is_num = vim.wo[win].number
    local is_relnum = vim.wo[win].relativenumber
    if (is_num or is_relnum) and vim.v.virtnum == 0 then
        if vim.fn.has("nvim-0.11") == 1 then
            components[1] = "%l" -- 0.11 handles both the current and other lines with %l
        else
            if vim.v.relnum == 0 then
                components[1] = "%l"               -- the current line
            else
                components[1] = is_relnum and "%r" or "%l" -- other lines
            end
        end
    end

    components[1] = "%=" .. components[1] .. " " -- right align
    -- if vim.v.virtnum ~= 0 then components[1] = "%= " end

    return table.concat(components, "")
end

return M
