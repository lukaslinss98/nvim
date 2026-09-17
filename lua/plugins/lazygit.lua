return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	keys = {
		{
			"<leader>gg",
			"<cmd>LazyGit<cr>",
			desc = "Open LazyGit",
		},
		{
			"<leader>gc",
			"<cmd>LazyGitConfig<cr>",
			desc = "Open LazyGit Config",
		},
		{
			"<leader>gf",
			"<cmd>LazyGitCurrentFile<cr>",
			desc = "LazyGit Current File",
		},
		{
			"<leader>gF",
			"<cmd>LazyGitFilterCurrentFile<cr>",
			desc = "LazyGit Filter Current File",
		},
		{
			"<leader>gb",
			"<cmd>LazyGitFilter<cr>",
			desc = "LazyGit Filter (branches)",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		vim.g.lazygit_floating_window_winblend = 0
		vim.g.lazygit_floating_window_scaling_factor = 0.95
		vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
		vim.g.lazygit_floating_window_use_plenary = 1
		vim.g.lazygit_use_neovim_remote = 1
		vim.g.lazygit_use_custom_config_file_path = vim.fn.stdpath("config") .. "/lazygit.yml"
	vim.g.lazygit_custom_config_file_path = vim.fn.stdpath("config") .. "/lazygit.yml"
	end,
}