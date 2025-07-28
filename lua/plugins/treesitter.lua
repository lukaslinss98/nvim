require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
    "javascript",
    "typescript",
    "python",
    "go",
    "html",
    "css",
    "bash",
    "java",
    "kotlin",
    "markdown"
  },                   -- Add the languages you use
  highlight = {
    enable = true,     -- Enable syntax highlighting
  },
  indent = {
    enable = true,     -- Enable Tree-sitter-based indentation
  },
})
