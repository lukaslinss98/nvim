-- telescope
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>fa", builtin.find_files, {
	desc = "Telescope find files",
})
vim.keymap.set("n", "<leader>ff", builtin.git_files, { desc = "Telescope find git files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>en", function()
	builtin.find_files({
		cwd = vim.fn.stdpath("config"),
	})
end, { desc = "Telescope Edit NeoVim" })

-- Diagnostic navigation uses the native ]d / [d / <C-w>d
vim.keymap.set("n", "<leader>gq", vim.diagnostic.setloclist, { desc = "Diagnostics to location list" })

-- LSP keybindings
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions with Telescope",
	callback = function(event)
		local map = function(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc })
		end

		-- Native keys, upgraded to Telescope pickers
		map("grr", function()
			builtin.lsp_references({ include_declaration = false })
		end, "References")
		map("gri", builtin.lsp_implementations, "Implementations")
		map("grt", builtin.lsp_type_definitions, "Type definition")
		map("gO", builtin.lsp_document_symbols, "Document symbols")

		-- No native equivalent
		map("gd", builtin.lsp_definitions, "Go to definition")
		map("gD", vim.lsp.buf.declaration, "Go to declaration")
		map("<leader>ws", builtin.lsp_workspace_symbols, "Workspace symbols")

		-- Already native: K (hover), gra (code action), grn (rename),
		-- <C-s> in insert mode (signature help)

		-- format
		vim.keymap.set({ "n", "x" }, "<leader>fc", function()
			require("conform").format({
				async = true,
				lsp_fallback = true,
			})
		end, { desc = "[f]ormat [c]ode" })

		vim.keymap.set("n", "<leader>h", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			vim.notify(vim.lsp.inlay_hint.is_enabled() and "Enabled Inlay Hints" or "Disabled Inlay Hints")
		end)
	end,
})
