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
    "markdown",
    "turtle",
    "yaml"
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})
