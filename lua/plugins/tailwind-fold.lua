return {
	"razak17/tailwind-fold.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade" },
	config = function()
		require("tailwind-fold").setup({
			enabled = true,
			symbol = "…",
			highlight = {
				fg = "#38BDF8",
			},
		})
	end,
}
