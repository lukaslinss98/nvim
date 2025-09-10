local obsidian = require('obsidian')
vim.o.conceallevel = 2

obsidian.setup({
  workspaces = {
    {
      name = "obsidian-vault",
      path = "~/dev/obsidian/vault",
    },
  },
  templates = {
    folder = "Templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    -- A map for custom variables, the key should be the variable and the value a function
    substitutions = {},
  },
  mapping = {
    ["gf"] = function()
      return obsidian.util.gf_passthrough()
    end,
    opts = {
      noremap = false,
      expr = true,
      buffer = true
    }

  },
  note_id_func = function(title)
    if title ~= nil then
      return title
    else
      for _ = 1, 4 do
        return "" .. string.char(math.random(65, 90))
      end
    end
  end,
})
