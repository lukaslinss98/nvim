vim.opt.termguicolors = true

require("nvim-tree").setup({
  git = { enable = true, },
  view = {
    width = 40,
    side = "left",
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    group_empty = true,
    highlight_git = true,
    icons = {
      glyphs = {
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌"
        },
      },
    },
  },
})
