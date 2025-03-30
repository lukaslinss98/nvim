--require('vesper').setup({
--    transparent = false, -- Boolean: Sets the background to transparent
--    italics = {
--        comments = true, -- Boolean: Italicizes comments
--        keywords = true, -- Boolean: Italicizes keywords
--        functions = true, -- Boolean: Italicizes functions
--        strings = true, -- Boolean: Italicizes strings
--        variables = true, -- Boolean: Italicizes variables
--    },
--    overrides = {}, -- A dictionary of group names, can be a function returning a dictionary or a table.
--    palette_overrides = {}
--})

--require("rose-pine").setup({
   -- disable_background = true
-- })

vim.cmd("colorscheme fleet")
vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
