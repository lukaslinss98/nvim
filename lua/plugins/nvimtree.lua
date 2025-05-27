vim.opt.termguicolors = true

require("nvim-tree").setup({
    git = { enable = true, },
    renderer = {
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
    view = {
        side = "left",
    },
})
