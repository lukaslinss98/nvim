local obsidian = require('obsidian')
vim.o.conceallevel = 2

obsidian.setup({
  workspaces = {
    {
      name = "lukas-remote",
      path = "~/Documents/Obsidian",
    },
  },
  mapping = {
    ["gf"] = function ()
      return obsidian.util.gf_passthrough()
    end,
    opts = {
      noremap = false,
      expr = true,
      buffer = true
    }

  }
})
