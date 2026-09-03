# AGENTS.md

## Overview

This is a Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. All configuration is written in Lua. `CLAUDE.md` is a symlink to this file.

## Architecture

### Entry Point
`init.lua` requires modules explicitly, in a fixed order: `set` → `remap` → `autocommands` → `plugins.lazy` (installs plugins) → the individual `plugins.*` config modules. Files under `lua/plugins/` are **not** auto-loaded; a new config file must be added to `init.lua` after `plugins.lazy`.

### Core Modules
- `lua/set.lua` — vim options (leader key = space, 2-space tabs, relative numbers, system clipboard, autoread, no wrap, scrolloff 10)
- `lua/remap.lua` — core keybindings: `J`/`K` move lines, `<leader>n`/`p`/`x` buffer next/prev/delete, `<leader>w{c,l,r,d,u}` window close/navigate, `<leader>pv` netrw, `+`/`-` increment/decrement
- `lua/autocommands.lua` — auto-resize on `VimResized`, yank highlight, strip trailing whitespace on save, restore cursor position, absolute numbers in insert mode, `q` closes help/man/qf buffers, mkdir parent dirs on save, terminal enters insert mode without numbers, LSP document highlight under cursor, wrap + spell for markdown/text/gitcommit

### Plugin Configuration
Plugin **specs** live in `lua/plugins/lazy.lua` and are mostly bare (`{ "author/name" }`). Plugin **setup** lives in a separate file per plugin under `lua/plugins/`, required from `init.lua`:

- `lazy.lua` — lazy.nvim bootstrap and all plugin specs
- `lsp.lua` — Mason + mason-lspconfig (`lua_ls`, `vtsls`, `pyright`, `gopls`, `html`, `cssls`, `tailwindcss`, `yamlls`, `helm_ls`, `rust_analyzer`) with per-server `vim.lsp.config(...)` overrides; inlay hints enabled for gopls/vtsls/lua_ls; yamlls disables formatting and diagnostics under `charts/templates`
- `keymaps.lua` — global Telescope keys (`<leader>fa` files, `<leader>ff` git files, `<leader>fg` grep, `<leader>en` edit config, `<leader>ge`/`gE` next/prev diagnostic, `<leader>gd` diagnostic float, `<leader>gq` diagnostics to loclist) plus LSP keys attached via `LspAttach` (`K`, `gd`, `gD`, `gi`, `go`, `gr`, `<leader>ds`/`ws` symbols, `<leader>ca` code action, `<leader>fc` format, `<leader>h` toggle inlay hints)
- `blink.lua` — blink.cmp completion; Ctrl-p/n or arrows navigate, Ctrl-y/Tab/Enter accept, Ctrl-e hide, Ctrl-u/d scroll docs; sources: lsp, path, snippets, buffer
- `formatting.lua` — conform.nvim format-on-save (500 ms, LSP fallback): stylua, ruff_format + isort, prettierd→prettier (javascript, markdown), gofmt, google-java-format
- `theme.lua` — configures rose-pine, vague, gruvbox-material, tokyonight and jb.nvim; **active colorscheme: gruvbox-material** (medium). Other themes installed: nord, github-theme, catppuccin
- `telescope.lua` — fuzzy finder with custom path display and fzf-native backend
- `treesitter.lua` — 18 parsers (lua, js/ts/tsx, python, go, html, css, bash, java, kotlin, markdown, turtle, yaml, terraform, hcl, rust, helm); maps `*/charts/templates/*.yaml` to the `helm` filetype
- `snacks.lua` — dashboard, notifier, explorer (`<leader>ee` toggle, `<leader>ef` reveal file; oil stays the directory handler), image support, bigfile, statuscolumn, indent guides
- `oil.lua` — oil.nvim as default file explorer (with oil-git)
- `statusbar.lua` — lualine, shows attached LSP clients
- `autoclose.lua` — bracket/quote auto-pairing (disabled for `text`)
- `obsidian.lua` — obsidian.nvim, vault at `~/dev/obsidian/vault`, templates in `Templates/`
- `markdown.lua` — render-markdown.nvim
- `molten.lua` — molten-nvim + image.nvim (kitty backend) for Jupyter cells in python/markdown/quarto
- `tailwind-fold.lua` — tailwind-fold.nvim, folds long Tailwind class attributes
- `java.lua` — nvim-java setup and enables `jdtls`; must run before `lsp.lua`
- `noice.lua` — noice.nvim: LSP markdown overrides, auto signature help, bordered docs, routes that hide write/search/yank noise; `<leader>nh`/`nl`/`nd` history/last/dismiss, `<C-f>`/`<C-b>` scroll hover docs. Notifications render via the snacks notifier
- `smearcursor.lua` — smear-cursor.nvim (currently `enabled = false`)

`lazy.lua` contains specs only, no `opts`/`config`. Plugins that need no setup call (which-key, vim-tmux-navigator with `<C-h/j/k/l>` keys, ascii.nvim) have no config file.

### Keybinding Split
Global keybindings live in `remap.lua`. Telescope and LSP keybindings live in `keymaps.lua` (LSP ones via `LspAttach`). Plugin-specific keys (molten, oil) live in that plugin's config file.

## Adding/Modifying Plugins

1. Add the spec to `lua/plugins/lazy.lua`, e.g. `{ "author/plugin-name", dependencies = { ... } }`. For lazy loading use `event`, `cmd`, `ft`, or `keys`.
2. Create `lua/plugins/<name>.lua` containing `require("plugin-name").setup({ ... })`.
3. Add `require("plugins.<name>")` to `init.lua` after `require("plugins.lazy")`.

Do not put `opts`/`config` in `lazy.lua`. There is no `ftplugin/` directory; filetype-specific behaviour is done with `FileType` autocommands.

## LSP Servers

Managed by Mason. To add a server: add it to `ensure_installed` in `lsp.lua` and, if it needs settings, add a `vim.lsp.config("<server>", { ... })` block.

## Formatters

Configured in `formatting.lua` via conform.nvim. Add an entry to `formatters_by_ft`. Formatter binaries are not installed by Mason automatically; install them manually (or via `:Mason`).
