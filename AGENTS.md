# AGENTS.md

This file provides guidance for agentic coding agents working with this Neovim configuration
repository.

## Overview

This is a Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin
manager. All configuration is written in Lua.

## Project Structure

```
nvim/
├── init.lua                 # Entry point - loads core modules
├── lua/
│   ├── set.lua              # vim options (leader, tabs, clipboard)
│   ├── remap.lua            # global keybindings
│   ├── autocommands.lua     # auto-resize, yank highlight, etc.
│   └── plugins/
│       ├── lazy.lua         # lazy.nvim bootstrap + plugin specs
│       ├── lsp.lua          # LSP servers (mason + lspconfig)
│       ├── blink.lua        # blink.cmp completion engine
│       ├── formatting.lua   # conform.nvim formatters
│       ├── telescope.lua    # fuzzy finder
│       ├── treesitter.lua    # syntax highlighting
│       ├── theme.lua        # colorscheme
│       ├── keymaps.lua      # LSP/Telescope keybindings
│       └── snacks.lua       # dashboard, notifications
├── ftplugin/                # filetype-specific config
└── CLAUDE.md                # Claude Code guidance
```

## Build / Lint / Test Commands

This is a Neovim configuration repository, not a traditional software project. There are no build
commands or formal tests.

### Validation Commands

```bash
# Open Neovim and run health checks
nvim --headless -c "checkhealth" -c "qa!"

# Check plugin status (run inside nvim)
:Lazy

# Check for configuration errors (run inside nvim)
:nvim --version
```

### Plugin Management

```bash
# Sync plugins (run inside nvim)
:Lazy sync

# Update plugins (run inside nvim)
:Lazy

# Clean unused plugins (run inside nvim)
:Lazy clean
```

### Formatters and Linters

Formatters are configured via conform.nvim in `lua/plugins/formatting.lua`:

- Lua: stylua
- Python: ruff_format + isort
- Java: google-java-format
- Go: gofmt
- JavaScript/Markdown: prettier

Run format on save is enabled (timeout_ms: 500).

## Code Style Guidelines

### Indentation

- **2 spaces** (no tabs)
- `expandtab = true` is enabled globally
- Use spaces consistently in all Lua files

```lua
-- Correct
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Incorrect
vim.opt.tabstop=2
```

### Lua Syntax

- **No semicolons** at end of statements
- Use `local` for variables unless explicitly global
- Prefer `vim.keymap.set()` over `vim.api.nvim_set_keymap()`

```lua
-- Preferred
local lspconfig = require("lspconfig")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw" })

-- Avoid
local lspconfig = require("lspconfig");
vim.api.nvim_set_keymap("n", "<leader>pv", ":Ex<CR>", { noremap = true });
```

### Table Formatting

```lua
-- Use spaces inside braces
local tbl = { key = "value", another = 123 }

-- Nested tables
local nested = {
    level1 = {
        level2 = {
            value = true
        }
    }
}
```

### Plugin Spec Pattern

When adding plugins to `lua/plugins/lazy.lua`:

```lua
{
    "author/plugin-name",
    dependencies = { "dependency/plugin" },
    event = "BufReadPre",          -- or "VeryLazy", "Cmd", "ft"
    opts = {},                     -- or config = function() ... end
    keys = {
        { "n", "<leader>key", function() ... end, { desc = "Description" } }
    }
}
```

### Keybinding Conventions

```lua
-- Use noremap and silent by default
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw", noremap = true, silent = true })

-- Use descriptive desc field with brackets for grouping
vim.keymap.set("n", "<leader>wl", "<c-w>h", { desc = "[W]indow [L]eft" })

-- Use expr only when necessary
vim.keymap.set("n", "goo", function()
    return require("opencode").operator("@this ") .. "_"
end, { desc = "Add line to opencode", expr = true })
```

### Naming Conventions

- **Files**: snake_case.lua (e.g., `lsp_config.lua`, `formatting.lua`)
- **Variables**: snake_case (e.g., `local lsp_defaults`)
- **Functions**: snake_case (e.g., `function get_root_dir()`)
- **Tables/Modules**: PascalCase for module names, snake_case for keys

### Error Handling

```lua
-- Simple shell error checking
if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
    }, true, {})
    os.exit(1)
end
```

### LSP Configuration

- Use `vim.lsp.config()` for Neovim 0.11+ style
- Use `root_pattern` from `lspconfig.util` for root directory detection
- Extend capabilities with blink.cmp:

```lua
local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities =
    vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("blink.cmp").get_lsp_capabilities())
```

### Imports and Requires

```lua
-- Use local for all requires
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

-- Only expose globals when necessary (vim, require are implicit globals)
```

## Adding New Plugins

1. Add plugin spec to `lua/plugins/lazy.lua` or create new file in `lua/plugins/`
2. Use lazy loading via `event`, `cmd`, or `ft` keys when possible
3. Add keybindings to appropriate file (global: `remap.lua`, LSP-specific: `keymaps.lua`)
4. Add formatter if needed to `formatting.lua` conform config
5. Add LSP server to `lsp.lua` if applicable

## Filetype-Specific Configuration

Place filetype-specific config in `ftplugin/` directory:

- `ftplugin/python.lua` - Python-specific settings
- `ftplugin/go.lua` - Go-specific settings
