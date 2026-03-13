# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. All configuration is written in Lua.

## Architecture

### Entry Point
`init.lua` loads core modules in order: `set.lua` → `remap.lua` → `autocommands.lua` → all files in `lua/plugins/`.

### Core Modules
- `lua/set.lua` — vim options (leader key = space, 2-space tabs, system clipboard, etc.)
- `lua/remap.lua` — core keybindings (buffer nav, window management, line movement)
- `lua/autocommands.lua` — auto-resize, yank highlight, trailing whitespace removal, cursor restore

### Plugin Configuration
Each plugin has its own file under `lua/plugins/`. Key files:
- `lazy.lua` — lazy.nvim bootstrap and all plugin specs
- `lsp.lua` — LSP servers (lua_ls, vtsls, pyright, gopls, rust_analyzer, html, cssls, tailwindcss, yamlls) + Mason auto-install
- `blink.lua` — completion engine (blink.cmp), keymaps: Ctrl-p/n to navigate, Ctrl-y to accept
- `keymaps.lua` — LSP and Telescope keybindings attached via `LspAttach` autocommand
- `formatting.lua` — conform.nvim format-on-save (stylua, ruff+isort, prettier, gofmt, google-java-format)
- `theme.lua` — colorscheme setup; currently active: TokyoNight Night
- `telescope.lua` — fuzzy finder with custom path display and fzf native backend
- `treesitter.lua` — syntax highlighting for 16 languages
- `snacks.lua` — dashboard, image support, indent guides, notifications

### Keybinding Split
Global keybindings live in `remap.lua`. Plugin-specific keybindings (LSP, Telescope) live in `keymaps.lua` and are registered via autocommands or plugin `keys` specs.

## Adding/Modifying Plugins

Add plugin specs to `lua/plugins/lazy.lua` or create a new file in `lua/plugins/`. The lazy.nvim pattern used here:

```lua
{
  "author/plugin-name",
  dependencies = { "other/plugin" },
  config = function()
    require("plugin-name").setup({ ... })
  end,
}
```

For lazy loading: use `event`, `cmd`, or `ft` keys. For filetype-specific config: add files to `ftplugin/`.

## LSP Servers

Managed by Mason. To add a new server: add it to the `ensure_installed` list in `lsp.lua` and configure it in the `lspconfig` setup section.

## Formatters

Configured in `formatting.lua` via conform.nvim. To add a formatter for a filetype, add it to the `formatters_by_ft` table and ensure the tool is in Mason's `ensure_installed`.
