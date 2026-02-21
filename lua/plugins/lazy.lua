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
	{
		"nickjvandyke/opencode.nvim",
		version = "*", -- Latest stable release
		dependencies = {
			{
				"folke/snacks.nvim",
				optional = true,
			},
		},
		config = function()
			vim.g.opencode_opts = {
				-- Your configuration, if any; goto definition on the type or field for details
			}

			vim.o.autoread = true -- Required for `opts.events.reload`

			-- Recommended/example keymaps
			vim.keymap.set({ "n", "x" }, "<leader>oa", function()
				require("opencode").ask("", { submit = true })
			end, { desc = "[O]pen Code [A]sk…" })

			vim.keymap.set({ "v" }, "<leader>oa", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "[O]pen Code [A]sk…" })

			vim.keymap.set({ "n", "x" }, "<C-x>", function()
				require("opencode").select()
			end, { desc = "Execute opencode action…" })
			vim.keymap.set({ "n", "t" }, "<leader>ot", function()
				require("opencode").toggle()
			end, { desc = "[O]pencode [T]oggle" })

			vim.keymap.set({ "n", "x" }, "go", function()
				return require("opencode").operator("@this ")
			end, { desc = "Add range to opencode", expr = true })
			vim.keymap.set("n", "goo", function()
				return require("opencode").operator("@this ") .. "_"
			end, { desc = "Add line to opencode", expr = true })

			vim.keymap.set("n", "<S-C-u>", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "Scroll opencode up" })
			vim.keymap.set("n", "<S-C-d>", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "Scroll opencode down" })

			-- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
			vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
			vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
		end,
	},
	{
		"sphamba/smear-cursor.nvim",
		opts = {},
	},
	{
		"MaximilianLloyd/ascii.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	-- formatting manager
	{
		"stevearc/conform.nvim",
	},
	{
		"nvim-java/nvim-java",
		config = function()
			require("java").setup()
			vim.lsp.enable("jdtls")
		end,
	},
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
		opts = {},
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
		opts = {},
	},

	-- vim-tmux-navigator
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
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

	-- bufferline
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
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

	-- rename
	{
		"nvim-lua/plenary.nvim",
		"filipdutescu/renamer.nvim",
		branch = "master",
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

	-- lspkind
	{
		"onsails/lspkind.nvim",
		lazy = true,
	},
})
