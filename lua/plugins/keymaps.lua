-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fs', builtin.git_files, {desc = 'Telescope find git files'})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

-- nvim.tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")
vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<cr>")
