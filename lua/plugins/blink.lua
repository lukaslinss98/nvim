require('blink.cmp').setup({
  keymap = {
    preset = 'none', -- disable default keymaps

    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },

    ['<C-p>'] = { 'select_prev', 'fallback' },
    ['<C-n>'] = { 'select_next', 'fallback' },

    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },

    ['<C-e>'] = { 'hide', 'fallback' },
    ['<C-y>'] = { 'select_and_accept' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = { 'select_and_accept', 'fallback' },
  },

  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = 'mono', -- 'mono' or 'normal'
  },

  completion = {
    menu = {
      border = 'rounded',
      draw = {
        padding = { 0, 0 }, -- padding only on right side
        treesitter = { 'lsp' },
        columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind', gap = 1 } },
        components = (function()
          local mini_icons_ok, mini_icons = pcall(require, "mini.icons")
          local lspkind_ok, lspkind = pcall(require, "lspkind")

          return {
            kind_icon = {
              text = function(ctx)
                if vim.tbl_contains({ "Path" }, ctx.source_name)
                  and mini_icons_ok
                  and type(mini_icons.get_icon) == "function"
                then
                  local mini_icon, _ = mini_icons.get_icon(ctx.item.data.type, ctx.label)
                  if mini_icon then
                    return mini_icon .. ctx.icon_gap
                  end
                end

                if lspkind_ok then
                  local icon = lspkind.symbolic(ctx.kind, { mode = "symbol" })
                  if icon then
                    return icon .. ctx.icon_gap
                  end
                end

                -- fallback: no icon
                return ctx.icon_gap or ""
              end,

              highlight = function(ctx)
                if vim.tbl_contains({ "Path" }, ctx.source_name)
                  and mini_icons_ok
                  and type(mini_icons.get_icon) == "function"
                then
                  local mini_icon, mini_hl = mini_icons.get_icon(ctx.item.data.type, ctx.label)
                  if mini_icon and mini_hl then
                    return mini_hl
                  end
                end

                return ctx.kind_hl
              end,
            },

            kind = {
              highlight = function(ctx)
                if vim.tbl_contains({ "Path" }, ctx.source_name)
                  and mini_icons_ok
                  and type(mini_icons.get_icon) == "function"
                then
                  local mini_icon, mini_hl = mini_icons.get_icon(ctx.item.data.type, ctx.label)
                  if mini_icon and mini_hl then
                    return mini_hl
                  end
                end

                return ctx.kind_hl
              end,
            },
          }
        end)(),
      },
    },

    documentation = {
      window = {
        border = 'rounded',
      },
      auto_show = true,
      auto_show_delay_ms = 250,
    },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  fuzzy = { implementation = "prefer_rust_with_warning" }
})
