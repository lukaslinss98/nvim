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

  -- formatting manager
  {
    'stevearc/conform.nvim',
  },
  {
    'nvim-java/nvim-java',
    config = function()
      require('java').setup()
      vim.lsp.enable('jdtls')
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

  { "3rd/image.nvim",            event = "VeryLazy" },
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
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
  },

  -- oil git
  {
    "benomahony/oil-git.nvim",
    dependencies = { "stevearc/oil.nvim" },
  },

  -- notifications
  {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require("notify")
      notify.setup({
        stages = "fade_in_slide_out",
      })
      vim.notify = notify
    end,
  },

  -- render-markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  },

  -- obsidian
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    'shaunsingh/nord.nvim'
  },
  -- Github theme
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme'
  },

  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
  },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
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
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- vague theme
  { "vague2k/vague.nvim" },

  -- fleet dark theme
  { "felipeagc/fleet-theme-nvim" },

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
  { 'datsfilipe/vesper.nvim' },

  -- rose-pine theme
  {
    'rose-pine/neovim',
    name = 'rose-pine'
  },

  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      }
    }

  },

  -- bufferline
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons'
  },

  -- blink
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      'rafamadriz/friendly-snippets',
      'nvim-mini/mini.nvim'
    },
    version = '1.*'
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
      { "jay-babu/mason-nvim-dap.nvim" },

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
  }
})
