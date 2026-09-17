return {
	"nvim-mini/mini.nvim",
	lazy = false, -- must load at startup: mocks web-devicons for oil/lualine/render-markdown
	config = function()
		require("mini.icons").setup()
		require("mini.icons").mock_nvim_web_devicons()

		require("mini.pairs").setup()
		-- match old autoclose.nvim config: disable for text
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "text" },
			callback = function()
				vim.b.minipairs_disable = true
			end,
		})

		local clue = require("mini.clue")
		clue.setup({
			triggers = {
				{ mode = "n", keys = "<Leader>" },
				{ mode = "x", keys = "<Leader>" },
				{ mode = "i", keys = "<C-x>" },
				{ mode = "n", keys = "g" },
				{ mode = "x", keys = "g" },
				{ mode = "n", keys = "'" },
				{ mode = "n", keys = "`" },
				{ mode = "x", keys = "'" },
				{ mode = "x", keys = "`" },
				{ mode = "n", keys = '"' },
				{ mode = "x", keys = '"' },
				{ mode = "i", keys = "<C-r>" },
				{ mode = "c", keys = "<C-r>" },
				{ mode = "n", keys = "<C-w>" },
				{ mode = "n", keys = "z" },
				{ mode = "x", keys = "z" },
			},
			clues = {
				{ mode = "n", keys = "<Leader>d", desc = "+Database / symbols" },
				clue.gen_clues.builtin_completion(),
				clue.gen_clues.g(),
				clue.gen_clues.marks(),
				clue.gen_clues.registers(),
				clue.gen_clues.windows(),
				clue.gen_clues.z(),
			},
		})
	end,
}
