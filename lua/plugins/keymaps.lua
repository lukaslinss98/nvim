-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fs', builtin.git_files, {desc = 'Telescope find git files'})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

-- nvim.tree
vim.keymap.set("n", "<leader>eo", ":NvimTreeOpen<cr>")
vim.keymap.set("n", "<leader>c", ":NvimTreeClose<cr>")

-- fine command-line
vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap = true})
