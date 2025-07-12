vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move the current line up or down in normal mode
vim.keymap.set('n', 'K', ':m .-2<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', 'J', ':m .+1<CR>==', { noremap = true, silent = true })

-- Move the selected lines up or down in visual mode
vim.keymap.set('v', 'K',":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- buffers
vim.keymap.set("n", "<leader>n", ":bn<cr>")
vim.keymap.set("n", "<leader>p", ":bp<cr>")
vim.keymap.set("n", "<leader>x", ":bd<cr>")

-- window
vim.keymap.set("n", "<leader>wc", "<c-w>q", { desc = "[W]indow [C]lose"})
vim.keymap.set("n", "<leader>wl", "<c-w>h", { desc = "[W]indow [L]eft"})
vim.keymap.set("n", "<leader>wr", "<c-w>l", { desc = "[W]indow [R]ight"})
vim.keymap.set("n", "<leader>wd", "<c-w>j", { desc = "[W]indow [D]own"})
vim.keymap.set("n", "<leader>wu", "<c-w>k", { desc = "[W]indow [U]p"})
