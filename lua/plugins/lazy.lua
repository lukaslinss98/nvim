-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({

    -- vague theme
    {
        "vague2k/vague.nvim",
    },

    -- fleet dark theme
    {
        "felipeagc/fleet-theme-nvim",
    },

    -- monokai pro theme
    {
        'loctvl842/monokai-pro.nvim',
        name = 'monokai'
    },

    -- catppuccin theme
    {
        'catppuccin/nvim',
        name = "catppuccin"
    },

    -- vesper theme
    {
        'datsfilipe/vesper.nvim'
    },

    -- rose-pine theme
    {
        'rose-pine/neovim',
        name = 'rose-pine'
    },

    -- fine command-line
    {
        'MunifTanjim/nui.nvim',
        dependencies = { 'VonHeikemen/fine-cmdline.nvim' }
    },

    -- telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- nvim-tree
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        }
    },

    -- bufferline
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons'
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter'
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
    },

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",                     -- Automatically update parsers after installation
        event = { "BufReadPost", "BufNewFile" }, -- Load Tree-sitter when opening files
    },

    -- rename
    {
        'nvim-lua/plenary.nvim',
        'filipdutescu/renamer.nvim',
        branch = 'master',
    },

    -- statusbar
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    -- smearcursor
    {
        'sphamba/smear-cursor.nvim',
    },

    -- auto close
    {
        'm4xshen/autoclose.nvim'
    }
})
