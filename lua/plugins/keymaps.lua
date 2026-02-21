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

vim.keymap.set("n", "<leader>ge", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

-- LSP keybindings
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions with Telescope",
	callback = function(event)
		local opts = { buffer = event.buf }

		-- Hover and signature help (built-in)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)

		-- Definitions, declarations, implementations, references via Telescope
		vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)
		vim.keymap.set("n", "go", builtin.lsp_type_definitions, opts)
		vim.keymap.set("n", "gr", function()
			builtin.lsp_references({
				include_declaration = false,
			})
		end, opts)

		-- Telescope-powered symbol search
		vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, opts)
		vim.keymap.set("n", "<leader>ws", builtin.lsp_workspace_symbols, opts)

		-- Code actions and refactor
		if vim.lsp.buf.range_code_action then
			vim.keymap.set(
				"n",
				"<leader>ca",
				vim.lsp.buf.range_code_action,
				{ buffer = 0, desc = "Range code action." }
			)
		else
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0, desc = "Code action." })
		end

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
