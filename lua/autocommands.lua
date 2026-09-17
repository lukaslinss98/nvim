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
	pattern = { "help", "man", "qf", "lspinfo", "checkhealth", "dbout" },
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

-- LSP: highlight word under cursor (only for servers that support it)
vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	group = "LspDocumentHighlight",
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client or not client:supports_method("textDocument/documentHighlight") then
			return
		end

		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = "LspDocumentHighlight",
			buffer = args.buf,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			group = "LspDocumentHighlight",
			buffer = args.buf,
			callback = vim.lsp.buf.clear_references,
		})
	end,
})

vim.api.nvim_create_autocmd("LspDetach", {
	group = "LspDocumentHighlight",
	callback = function(args)
		vim.lsp.buf.clear_references()
		vim.api.nvim_clear_autocmds({ group = "LspDocumentHighlight", buffer = args.buf })
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
