local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

vim.opt.signcolumn = "yes"
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
})

local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities =
	vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("blink.cmp").get_lsp_capabilities())

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"vtsls",
		"pyright",
		"gopls",
		"html",
		"cssls",
		"tailwindcss",
		"yamlls",
	},
	automatic_installation = true,
})

vim.lsp.config("pyright", {
	seroot_dir = function(fname)
		return util.root_pattern(".git", "pyrightconfig.json", "pyproject.toml")(fname) or vim.fs.dirname(fname)
	end,
	settings = {
		python = {
			analysis = {
				extraPaths = { "." },
			},
		},
	},
})

vim.lsp.config("gopls", {
	settings = {
		hints = {
			rangeVariableTypes = true,
			parameterNames = true,
			constantValues = true,
			assignVariableTypes = true,
			compositeLiteralFields = true,
			compositeLiteralTypes = true,
			functionTypeParameters = true,
		},
	},
})

vim.lsp.config("vtsls", {
	settings = {
		typescript = {
			inlayHints = {
				parameterNames = { enabled = "all" },
				parameterTypes = { enabled = true },
				variableTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				enumMemberValues = { enabled = true },
			},
			suggest = {
				completeFunctionCalls = true,
			},
		},
		vtsls = {
			experimental = {
				enableProjectDiagnostics = true,
			},
		},
	},
	filetypes = {
		"typescript",
		"typescriptreact",
		"javascript",
		"javascriptreact",
	},
})

vim.lsp.config("tailwindcss", {
	root_dir = function(fname)
		return require("lspconfig.util").root_pattern(
			"tailwind.config.js",
			"tailwind.config.ts",
			"postcss.config.js",
			"postcss.config.ts",
			"package.json",
			"node_modules",
			".git"
		)(fname)
	end,
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			hint = { enable = true },
			diagnostics = {
				globals = {
					"vim",
					"require",
				},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})
