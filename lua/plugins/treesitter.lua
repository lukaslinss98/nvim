return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	init = function()
		vim.filetype.add({
			pattern = {
				[".*/charts/templates/.*%.yaml"] = "helm",
			},
		})
	end,
	config = function()
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
	end,
}
