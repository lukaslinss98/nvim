# AGENTS.md

## Overview

This is a Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. All configuration is written in Lua. `CLAUDE.md` is a symlink to this file.

## Architecture

### Entry Point
`init.lua` requires modules explicitly, in a fixed order: `set` → `remap` → `autocommands` → `config.lazy` (bootstraps lazy.nvim) → `config.keymaps`. lazy.nvim auto-imports every spec file in `lua/plugins/` via `{ import = "plugins" }`, so there are no per-plugin `require` calls — a new plugin is a single new file under `lua/plugins/`. Non-plugin config lives in `lua/config/`.

### Core Modules
- `lua/set.lua` — vim options (leader key = space, 2-space tabs, relative numbers, system clipboard, autoread, no wrap, scrolloff 10)
- `lua/remap.lua` — core keybindings: `J`/`K` move lines, `<leader>n`/`p`/`x` buffer next/prev/delete, `<leader>w{c,l,r,d,u}` window close/navigate, `<leader>pv` netrw, `+`/`-` increment/decrement
- `lua/autocommands.lua` — auto-resize on `VimResized`, yank highlight, strip trailing whitespace on save, restore cursor position, absolute numbers in insert mode, `q` closes help/man/qf buffers, mkdir parent dirs on save, terminal enters insert mode without numbers, LSP document highlight under cursor, wrap + spell for markdown/text/gitcommit

### Plugin Configuration
Each file under `lua/plugins/` returns a lazy.nvim spec (`return { "author/plugin", opts/config/keys/... }`) that merges the old spec block with its setup call. `lua/config/lazy.lua` only bootstraps lazy.nvim and declares `spec = { { import = "plugins" } }`:

- `config/lazy.lua` — lazy.nvim bootstrap and `{ import = "plugins" }` spec (must live outside `lua/plugins/` so lazy doesn't import itself)
- `lsp.lua` — Mason + mason-lspconfig (`lua_ls`, `vtsls`, `pyright`, `prismals`, `gopls`, `html`, `cssls`, `tailwindcss`, `yamlls`, `helm_ls`, `rust_analyzer`) with per-server `vim.lsp.config(...)` overrides; inlay hints enabled for gopls/vtsls/lua_ls; yamlls disables formatting and diagnostics under `charts/templates`
- `config/keymaps.lua` — global Telescope keys (`<leader>fa` files, `<leader>ff` git files, `<leader>fg` grep, `<leader>en` edit config, `<leader>ge`/`gE` next/prev diagnostic, `<leader>gD` diagnostic float, `<leader>gq` diagnostics to loclist) plus LSP keys attached via `LspAttach` (`K`, `gd`, `gD`, `gi`, `go`, `gr`, `<leader>ds`/`ws` symbols, `<leader>ca` code action, `<leader>fc` format, `<leader>h` toggle inlay hints); required from `init.lua`, not a plugin spec
- `blink.lua` — blink.cmp completion; Ctrl-p/n or arrows navigate, Ctrl-y/Tab/Enter accept, Ctrl-e hide, Ctrl-u/d scroll docs; sources: lsp, path, snippets, buffer
- `formatting.lua` — conform.nvim format-on-save (500 ms, LSP fallback): stylua, ruff_format + isort, prettierd→prettier (javascript, markdown), gofmt, google-java-format
- `theme.lua` — returns one spec per theme (rose-pine, vague, gruvbox-material, tokyonight, jb.nvim, nord, github-theme, catppuccin); **active colorscheme: tokyonight-night**, applied in the tokyonight spec's `config`
- `telescope.lua` — fuzzy finder with custom path display and fzf-native backend
- `treesitter.lua` — nvim-treesitter on the `main` branch (`master` is EOL and its query directives crash on Neovim 0.12); requires the `tree-sitter` CLI (`brew install tree-sitter-cli`) to build parsers, and `lazy = false` since `main` does not support lazy-loading. 20 parsers (lua, js/ts/tsx, python, prisma, go, html, css, bash, java, kotlin, markdown, markdown_inline, turtle, yaml, terraform, hcl, rust, helm) installed asynchronously into `stdpath("data")/site`. `main` has no `ensure_installed`/`highlight`/`indent` options: a `FileType` autocommand calls `vim.treesitter.start` and sets the treesitter `indentexpr`, but only for languages that ship an `indents` query (helm/kotlin/markdown_inline/prisma ship none, and their indentation would otherwise flatten to column 0). Maps `*/charts/templates/*.yaml` to the `helm` filetype
- `snacks.lua` — dashboard, notifier, explorer (`<leader>ee` toggle, `<leader>ef` reveal file; oil stays the directory handler), image support, bigfile, statuscolumn, indent guides
- `oil.lua` — oil.nvim as default file explorer (with oil-git)
- `statusbar.lua` — lualine, shows attached LSP clients
- `autoclose.lua` — bracket/quote auto-pairing (disabled for `text`)
- `obsidian.lua` — obsidian.nvim, vault at `~/dev/obsidian/vault`, templates in `Templates/`
- `markdown.lua` — render-markdown.nvim
- `molten.lua` — molten-nvim + image.nvim (kitty backend) for Jupyter cells in python/markdown/quarto
- `tailwind-fold.lua` — tailwind-fold.nvim, folds long Tailwind class attributes
- `java.lua` — nvim-java setup and enables `jdtls`; loaded as a dependency of the lsp spec (ordering guaranteed by lazy, not `init.lua`)
- `noice.lua` — noice.nvim: LSP markdown overrides, auto signature help, bordered docs, routes that hide write/search/yank noise; `<leader>nh`/`nl`/`nd` history/last/dismiss, `<C-f>`/`<C-b>` scroll hover docs. Notifications render via the snacks notifier
- `smearcursor.lua` — smear-cursor.nvim (currently `enabled = false`)
- `dadbod.lua` — vim-dadbod + vim-dadbod-ui + vim-dadbod-completion SQL client. DBUI is `cmd`-lazy with `<leader>db` toggle, `<leader>df` find buffer, `<leader>da` add connection; `vim.g.db_ui_*` options set in `init` (nerd fonts, save location under `stdpath("data")/dadbod_ui`, `execute_on_save` off — run queries with DBUI's `<leader>S`). Also disables Neovim's built-in `sql_completion` omnifunc. Completion is wired into blink via the native `vim_dadbod_completion.blink` source: `blink.lua` declares a `dadbod` provider and `sources.per_filetype` for sql/mysql/plsql (no blink.compat needed). Connections come from `:DBUIAddConnection`, `$DBUI_URL`, or `vim.g.dbs`; none live in the repo. `q` closes `dbout` result windows (autocommands.lua)

Small dependency-only plugins are folded in where they belong: ascii.nvim lives in the telescope spec's `dependencies`, oil-git in oil's, friendly-snippets in blink's; image.nvim is a co-spec in `molten.lua`. Standalone no-setup specs are `which-key.lua` and `tmux-navigator.lua` (the latter with herdr `<C-h/j/k/l>` mappings).

### Keybinding Split
Global keybindings live in `remap.lua`. Telescope and LSP keybindings live in `config/keymaps.lua` (LSP ones via `LspAttach`). Plugin-specific keys use lazy `keys` in that plugin's spec (oil `<leader>pv`, snacks `<leader>ee`/`ef`, noice `<leader>nh`/`nl`/`nd` + `<C-f>`/`<C-b>`, lazygit `<leader>gg`/`gc`/`gf`/`gF`/`gb`, dadbod `<leader>db`/`df`/`da`); molten keeps a `FileType` autocommand for buffer-local maps.

## Adding/Modifying Plugins

1. Create `lua/plugins/<name>.lua` containing `return { "author/plugin-name", ... }` with the setup table as `opts = { ... }` (or `config = function() ... end` when keymaps/autocommands/globals are involved). Declare lazy loading with `event`, `cmd`, `ft`, or `keys`, and load order with `dependencies`.
2. Done — lazy auto-imports the file. No `init.lua` change needed.

Prefer `opts` over `config` for pure `setup()` calls. `init` runs at startup even for lazy-loaded plugins (use for `vim.g` flags and `vim.filetype.add`); `config` runs on load. Caution: adding `keys`, `event`, `cmd`, or `ft` makes a plugin lazy — startup-critical plugins (snacks dashboard, noice) need explicit `lazy = false`. Files in `lua/config/` are for non-plugin setup and must be required from `init.lua` explicitly.

## LSP Servers

Managed by Mason. To add a server: add it to `ensure_installed` in `lsp.lua` and, if it needs settings, add a `vim.lsp.config("<server>", { ... })` block.

## Formatters

Configured in `formatting.lua` via conform.nvim. Add an entry to `formatters_by_ft`. Formatter binaries are not installed by Mason automatically; install them manually (or via `:Mason`).
