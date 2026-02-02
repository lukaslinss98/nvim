vim.g.molten_default_kernel = "python3"
vim.g.molten_image_provider = "image.nvim"
vim.g.molten_output_virt_lines = false
vim.g.molten_virt_lines_off_by_1 = true
vim.g.molten_wrap_output = true
vim.g.molten_output_show_more = true
vim.g.molten_virt_text_output = false
vim.g.molten_auto_open_output = true

require("image").setup({
  backend = "kitty",                        
  max_width = 100,                         
  max_height = 12,                        
  integrations = { markdown = { enabled = true } },
  max_height_window_percentage = math.huge,
  max_width_window_percentage = math.huge,
  window_overlap_clear_enabled = true,
  window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },

})

local function map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", { buffer = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "markdown", "quarto" },
  callback = function()
    map("n", "<leader>mi", ":MoltenInit<CR>", { desc = "Molten: Init kernel" })
    map("n", "<leader>rl", ":MoltenEvaluateLine<CR>", { desc = "Molten: Eval line" })
    map("v", "<leader>rr", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Molten: Eval visual" })
    map("n", "<leader>ro", ":MoltenEnterOutput 1<CR>", { desc = "Molten: Show output" })
    map("n", "<leader>rh", ":MoltenHideOutput<CR>", { desc = "Molten: Hide output" })
    map("n", "<leader>md", ":MoltenDelete<CR>", { desc = "Molten: Delete" })
  end,
})
