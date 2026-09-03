require("noice").setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
		},
		-- show signature help automatically while typing arguments
		signature = {
			auto_open = { enabled = true },
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = true,
	},
	routes = {
		-- "file written" messages
		{ filter = { event = "msg_show", kind = "", find = "written" }, opts = { skip = true } },
		-- "search hit BOTTOM" / "N of M" search counts
		{ filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },
		-- "N lines yanked", "N fewer lines", "N more lines"
		{ filter = { event = "msg_show", find = "^%d+ %a+ lines" }, opts = { skip = true } },
		{ filter = { event = "msg_show", find = "^%d+ lines" }, opts = { skip = true } },
		-- "42L, 1337B" file info on :w / :e
		{ filter = { event = "msg_show", find = "%d+L, %d+B" }, opts = { skip = true } },
	},
})

-- message history
vim.keymap.set("n", "<leader>nh", "<cmd>Noice history<cr>", { desc = "[N]oice [H]istory" })
vim.keymap.set("n", "<leader>nl", "<cmd>Noice last<cr>", { desc = "[N]oice [L]ast message" })
vim.keymap.set("n", "<leader>nd", "<cmd>Noice dismiss<cr>", { desc = "[N]oice [D]ismiss" })

-- scroll LSP hover / signature windows without focusing them
vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
	if not require("noice.lsp").scroll(4) then
		return "<c-f>"
	end
end, { silent = true, expr = true, desc = "Scroll LSP docs forward" })
vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
	if not require("noice.lsp").scroll(-4) then
		return "<c-b>"
	end
end, { silent = true, expr = true, desc = "Scroll LSP docs backward" })
