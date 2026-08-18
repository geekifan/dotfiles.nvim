return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local parsers = {
                "c",
                "cpp",
                "python",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "markdown",
                "markdown_inline",
                "regex",
            }

            local treesitter = require("nvim-treesitter")
            treesitter.setup({})
            treesitter.install(parsers)

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
                callback = function(args)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
                    if ok and stats and stats.size > max_filesize then
                        return
                    end

                    pcall(vim.treesitter.start, args.buf)
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufRead",
        opts = {},
    },
}