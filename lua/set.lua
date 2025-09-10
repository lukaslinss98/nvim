vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.scrolloff = 10

vim.g.mapleader = " "

vim.opt.fillchars = { eob = " " }

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(ctx)
    local bufname = vim.api.nvim_buf_get_name(ctx.buf)
    if bufname and bufname ~= "" and vim.loop.fs_stat(bufname) then
      local dir = vim.fn.fnamemodify(bufname, ":p:h")
      if dir and dir ~= "" then
        vim.cmd("silent lcd " .. vim.fn.fnameescape(dir))
      end
    end
  end,
})

