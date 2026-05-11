require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"javascript",
		"typescript",
		"tsx",
		"python",
		"go",
		"html",
		"css",
		"bash",
		"java",
		"kotlin",
		"markdown",
		"turtle",
		"yaml",
		"terraform",
		"hcl",
		"rust",
		"helm",
	},
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})

vim.filetype.add({
	pattern = {
		[".*/charts/templates/.*%.yaml"] = "helm",
	},
})
