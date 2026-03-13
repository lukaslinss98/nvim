vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
	command = "set norelativenumber",
})

vim.api.nvim_create_autocmd("InsertLeave", {
	command = "set relativenumber",
})

-- Close utility buffers with 'q'
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "man", "qf", "lspinfo", "checkhealth" },
	callback = function()
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
	end,
})

-- Auto-create missing parent directories on save
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(event)
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Terminal: insert mode, no line numbers
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.cmd("startinsert")
	end,
})

-- LSP: highlight word under cursor
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	callback = function()
		vim.lsp.buf.document_highlight()
	end,
})
vim.api.nvim_create_autocmd("CursorMoved", {
	callback = function()
		vim.lsp.buf.clear_references()
	end,
})

-- Prose files: wrap and spell check
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})
