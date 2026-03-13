require("rose-pine").setup({
	styles = {
		transparency = true,
	},
})

require("vague").setup({
	-- Don't set background
	transparent = true,
	-- Disable bold/italic globally
	bold = true,
	italic = true,

	-- Override highlights or add new highlights
	on_highlights = function(highlights, colors) end,

	-- Override colors
	colors = {
		bg = "#141415",
		inactiveBg = "#1c1c24",
		fg = "#cdcdcd",
		floatBorder = "#878787",
		line = "#252530",
		comment = "#606079",
		builtin = "#b4d4cf",
		func = "#c48282",
		string = "#e8b589",
		number = "#e0a363",
		property = "#c3c3d5",
		constant = "#aeaed1",
		parameter = "#bb9dbd",
		visual = "#333738",
		error = "#d8647e",
		warning = "#f3be7c",
		hint = "#7e98e8",
		operator = "#90a0b5",
		keyword = "#6e94b2",
		type = "#9bb4bc",
		search = "#405065",
		plus = "#7fa563",
		delta = "#f3be7c",
	},
})

vim.g.gruvbox_material_background = "medium" -- "soft", "medium", "hard"
vim.g.gruvbox_material_enable_italic = 1 -- 0 or 1
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_foreground = "material"

require("tokyonight").setup({
	transparent = false,
	styles = {
		sidebars = "transparent",
		floats = "transparent",
	},
})

--  vim.cmd.colorscheme("gruvbox-material")
vim.cmd.colorscheme("tokyonight-night")
