return {
	"nvim-mini/mini.nvim",
	config = function()
		require("mini.pairs").setup()
		-- match old autoclose.nvim config: disable for text
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "text" },
			callback = function()
				vim.b.minipairs_disable = true
			end,
		})
	end,
}
