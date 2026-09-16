-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "sphamba/smear-cursor.nvim" },
	{
		"MaximilianLloyd/ascii.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	-- lazy.nvim
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},

	-- formatting manager
	{
		"stevearc/conform.nvim",
	},
	{ "nvim-java/nvim-java" },
	{
		"benlubas/molten-nvim",
		version = "^1.0.0",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"3rd/image.nvim",
		},
		event = { "BufReadPre *.py", "BufNewFile *.py" },
	},
	{ "3rd/image.nvim", event = "VeryLazy" },
	-- intellij theme
	{
		"nickkadutskyi/jb.nvim",
		lazy = false,
		priority = 1000,
	},
	-- snacks
	{
		"folke/snacks.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},

	-- oil
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
	},

	-- oil git
	{
		"benomahony/oil-git.nvim",
		dependencies = { "stevearc/oil.nvim" },
	},

	-- render-markdown
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	},

	-- obsidian
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"shaunsingh/nord.nvim",
	},
	-- Github theme
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
	},

	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
	},

	-- tokyonight
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},

	-- vim-herdr-navigation (herdr-aware, falls back to tmux/plain wincmd)
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		init = function()
			vim.g.tmux_navigator_no_mappings = 1
		end,
		config = function()
			dofile(vim.fn.expand("~/.config/herdr/vim-herdr-navigation/editor/nvim.lua"))
		end,
	},
	-- vague theme
	{ "vague2k/vague.nvim" },

	-- catppuccin theme
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},

	-- rose-pine theme
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
	},

	-- blink
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"nvim-mini/mini.nvim",
		},
		version = "1.*",
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "jay-babu/mason-nvim-dap.nvim" },
		},
	},

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
	},

	-- statusbar
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- auto close
	{
		"m4xshen/autoclose.nvim",
	},

	-- which key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
	},

	-- tailwind-fold
	{
		"razak17/tailwind-fold.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
})
