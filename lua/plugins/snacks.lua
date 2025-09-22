require("snacks").setup({
  image = { enabled = true },
  picker = { enabled = true },
  dashboard = { enabled = true },
  backends = {
    ghostty = true,
    tmux = true,
  },
  features = {
    markdown = true,
    latex = false,
    mermaid = false,
  },
})
