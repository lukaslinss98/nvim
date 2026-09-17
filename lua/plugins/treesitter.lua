local parsers = {
	"bash",
	"css",
	"go",
	"hcl",
	"helm",
	"html",
	"java",
	"javascript",
	"kotlin",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"rust",
	"terraform",
	"tsx",
	"turtle",
	"typescript",
	"yaml",
}

-- Enable highlighting (and indent, where the parser ships an indents query) for
-- a buffer. `main` enables nothing on its own. Filetype -> parser mapping comes
-- from the plugin's own `plugin/filetypes.lua` (typescriptreact -> tsx, ...);
-- `vim.treesitter.start` asserts on a missing parser, hence the pcall.
local function start(buf)
	if not vim.api.nvim_buf_is_valid(buf) then
		return
	end
	local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
	if not lang or not pcall(vim.treesitter.start, buf, lang) then
		return
	end
	-- Without an indents query nvim-treesitter's indentexpr flattens every line
	-- to column 0 (helm, kotlin, markdown_inline ship none).
	if vim.treesitter.query.get(lang, "indents") then
		vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
end

local function start_all()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) then
			start(buf)
		end
	end
end

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main", -- `master` is EOL and its query directives crash on nvim 0.12
	lazy = false, -- main does not support lazy-loading
	build = ":TSUpdate",
	init = function()
		vim.filetype.add({
			pattern = {
				[".*/charts/templates/.*%.yaml"] = "helm",
			},
		})
	end,
	config = function()
		local ts = require("nvim-treesitter")

		-- Passing install_dir prepends it to runtimepath, so these parsers and
		-- queries win over the ones bundled with Neovim.
		ts.setup({ install_dir = vim.fn.stdpath("data") .. "/site" })

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
			callback = function(args)
				start(args.buf)
			end,
		})

		local installed = ts.get_installed("parsers")
		local missing = vim.tbl_filter(function(parser)
			return not vim.tbl_contains(installed, parser)
		end, parsers)
		if #missing > 0 then
			-- Async: never block startup. Light up open buffers once it lands.
			ts.install(missing):await(vim.schedule_wrap(start_all))
		end

		start_all()
	end,
}
