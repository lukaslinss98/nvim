local lspconfig = require('lspconfig')

vim.opt.signcolumn = 'yes'
vim.diagnostic.config({
  virtual_text = true, -- show inline text
  signs = true,        -- show signs in the gutter (like the red E)
  underline = true,    -- underline the line with the issue
  update_in_insert = false,
  severity_sort = true,
})

-- Set up default capabilities with extensions
local lsp_defaults = lspconfig.util.default_config
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
    "lua_ls",
    "kotlin_language_server",
    "vtsls",
    "pyright",
    "gopls",
    "html",
    "cssls",
    "tailwindcss",
    "jdtls"
  },

  automatic_installation = true,

  handlers = {
    function(server_name)
      lspconfig[server_name].setup({})
    end,

    ["vtsls"] = function()
      require("lspconfig").vtsls.setup({
        -- Optional, but recommended
        settings = {
          typescript = {
            suggest = {
              completeFunctionCalls = true
            }
          },
          vtsls = {
            experimental = {
              enableProjectDiagnostics = true
            }
          }
        },
        filetypes = {
          "typescript",
          "typescriptreact",
          "javascript",
          "javascriptreact"
        },
      })
    end,

    ["tailwindcss"] = function()
      lspconfig.tailwindcss.setup({
        root_dir = function(fname)
          return require('lspconfig.util').root_pattern(
            'tailwind.config.js',
            'tailwind.config.ts',
            'postcss.config.js',
            'postcss.config.ts',
            'package.json',
            'node_modules',
            '.git'
          )(fname)
        end,
      })
    end,

    ["jdtls"] = function() end,

    ["lua_ls"] = function()
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
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
