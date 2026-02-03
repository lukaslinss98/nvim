local null_ls = require('null-ls')

null_ls.setup({
  debug = true,
  sources = {
    null_ls.builtins.formatting.google_java_format.with({
      filetypes = { "java" },
    }),
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort
  },
})
