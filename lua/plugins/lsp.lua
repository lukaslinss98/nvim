vim.opt.signcolumn = 'yes'

-- Set up default capabilities with extensions
local lsp_defaults = require('lspconfig').util.default_config
lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Setup Mason-lspconfig
require('mason-lspconfig').setup({
    ensure_installed = {
        --        "jdtls",
        "kotlin_language_server",
        "ts_ls",
        "pyright",
        "gopls",
        "html",
        "cssls",
        "tailwindcss",
    },

    automatic_installation = true,

    handlers = {

        function(server_name)
            if server_name ~= "jdtls" then
                require('lspconfig')[server_name].setup({})
            end
        end,

        ["jdtls"] = function() end,

        ["lua_ls"] = function()
            require('lspconfig').lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false
                        },
                        telemetry = {
                            enable = false
                        }
                    }
                }
            })
        end,
    }
})
