require("conform").setup({
	formatters_by_ft = {
		java = { "google-java-format" },
		go = { "gofmt" },
		lua = { "stylua" },
		python = { "ruff_format", "isort" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		markdown = { "prettierd", "prettier", stop_after_first = true },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})
