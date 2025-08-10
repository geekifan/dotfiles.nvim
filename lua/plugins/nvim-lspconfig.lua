local icons = require("config.icons")

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "mason-org/mason.nvim",
            opts = {
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            }
        },
        { "mason-org/mason-lspconfig.nvim", opts = {} },
    },
    opts = {
        inlay_hints = { enabled = true },
        codelens = { enabled = false },
        diagnostics = {
            underline = true,
            update_in_insert = false,
            virtual_text = {
                spacing = 4,
                source = "if_many",
                prefix = "●",
                -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
                -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
                -- prefix = "icons",
            },
            severity_sort = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                    [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
                    [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
                    [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
                },
            },
        },
    },
    config = function(_, opts)
        -- The following code is from LazyVim
        -- diagnostics signs
        if vim.fn.has("nvim-0.10.0") == 0 then
            if type(opts.diagnostics.signs) ~= "boolean" then
                for severity, icon in pairs(opts.diagnostics.signs.text) do
                    local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
                    name = "DiagnosticSign" .. name
                    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
                end
            end
        end
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("InlineHintsAndCodeLens", { clear = true }),
            callback = function(args)
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then return end
                if opts.inlay_hints.enabled and client.supports_method("textDocument/inlayHint") then
                    if vim.api.nvim_buf_is_valid(bufnr)
                    and vim.bo[bufnr].buftype == ""
                    and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[bufnr].filetype) then
                        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                    end
                end

                if opts.codelens.enabled and client.supports_method("textDocument/codeLens") then
                    vim.lsp.codelens.refresh()
                    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                        buffer = bufnr,
                        callback = vim.lsp.codelens.refresh,
                    })
                end
            end,
        })
        if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
            opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
                or function(diagnostic)
                    local icons = icons.diagnostics
                    for d, icon in pairs(icons) do
                        if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                            return icon
                        end
                    end
                end
        end

        vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    end
}
