vim.opt.signcolumn = 'yes'

-- Set up default capabilities with extensions
local lsp_defaults = require('lspconfig').util.default_config
lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

-- LSP keybindings
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions with Telescope',
    callback = function(event)
        local opts = { buffer = event.buf }
        local builtin = require('telescope.builtin')

        -- Hover and signature help (built-in)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)

        -- Definitions, declarations, implementations, references via Telescope
        vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', builtin.lsp_implementations, opts)
        vim.keymap.set('n', 'go', builtin.lsp_type_definitions, opts)
        vim.keymap.set('n', 'gr', builtin.lsp_references, opts)

        -- Telescope-powered symbol search
        vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, opts)
        vim.keymap.set('n', '<leader>ws', builtin.lsp_workspace_symbols, opts)

        -- Code actions and refactor
        vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
        vim.keymap.set('x', '<F4>', vim.lsp.buf.code_action, opts)

        -- Rename and format
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
})

-- Setup Mason (must be before mason-lspconfig)
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
        "jdtls",
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
            require('lspconfig')[server_name].setup({})
        end,

        ["lua_ls"] = function()
            require('lspconfig').lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" } -- Recognize vim as a global
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
