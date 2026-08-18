local icons = require("config.icons")

-- The config is from LazyVim
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
        { "mason-org/mason-lspconfig.nvim" },
    },
    opts = {
        inlay_hints = { enabled = true, exclude = {} },
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
        ensure_installed = {
            -- python
            "pylint", -- linter
            "debugpy", -- debugger
            "yapf", -- formatter
            -- other
            "copilot-language-server",
        },
        -- LSP Server Settings
        ---@type lspconfig.options
        servers = {
            pyright = {},
            lua_ls = {
                -- mason = false, -- set to false if you don't want this server to be installed with mason
                -- Use this to add any additional keymaps
                -- for specific lsp servers
                -- ---@type LazyKeysSpec[]
                -- keys = {},
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                        },
                        codeLens = {
                            enable = true,
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                        doc = {
                            privateName = { "^_" },
                        },
                        hint = {
                            enable = true,
                            setType = false,
                            paramType = true,
                            paramName = "Disable",
                            semicolon = "Disable",
                            arrayIndex = "Disable",
                        },
                    },
                },
            },
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        setup = {
            -- example to setup with typescript.nvim
            -- tsserver = function(_, opts)
            --   require("typescript").setup({ server = opts })
            --   return true
            -- end,
            -- Specify * to use this function as a fallback for any server
            -- ["*"] = function(server, opts) end,
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
                if opts.inlay_hints.enabled and client:supports_method("textDocument/inlayHint", bufnr) then
                    if vim.api.nvim_buf_is_valid(bufnr)
                    and vim.bo[bufnr].buftype == ""
                    and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[bufnr].filetype) then
                        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                    end
                end

                if opts.codelens.enabled and client:supports_method("textDocument/codeLens", bufnr) then
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

        local servers = opts.servers
        local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        local has_blink, blink = pcall(require, "blink.cmp")
        local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        has_blink and blink.get_lsp_capabilities() or {},
        opts.capabilities or {}
        )

        local function setup(server)
            local server_opts = vim.tbl_deep_extend("force", {
                capabilities = vim.deepcopy(capabilities),
            }, servers[server] or {})
            if server_opts.enabled == false then
                return false
            end

            if opts.setup[server] then
                if opts.setup[server](server, server_opts) then
                    return false
                end
            elseif opts.setup["*"] then
                if opts.setup["*"](server, server_opts) then
                    return false
                end
            end

            -- Register/extend the config using Neovim's native LSP API.
            vim.lsp.config(server, server_opts)
            return true
        end

        -- Configure every declared server before Mason enables it.
        local have_mason, mlsp = pcall(require, "mason-lspconfig")
        local mason_mappings = {}
        if have_mason then
            mason_mappings = mlsp.get_mappings().lspconfig_to_package

            -- Install non-LSP tools by their Mason package names.
            local registry = require("mason-registry")
            for _, name in ipairs(opts.ensure_installed) do
                local package = registry.get_package(name)
                if not package:is_installed() then
                    vim.notify("Installing " .. name, "info", { title = "Mason.nvim" })
                    package:install()
                end
            end
        end

        local mason_servers = {} ---@type string[]
        for server, server_opts in pairs(servers) do
            server_opts = server_opts == true and {} or server_opts
            if server_opts and server_opts.enabled ~= false and setup(server) then
                if have_mason and server_opts.mason ~= false and mason_mappings[server] then
                    mason_servers[#mason_servers + 1] = server
                else
                    vim.lsp.enable(server)
                end
            end
        end

        if have_mason then
            mlsp.setup({
                ensure_installed = mason_servers,
                automatic_enable = mason_servers,
            })
        end

    end
}