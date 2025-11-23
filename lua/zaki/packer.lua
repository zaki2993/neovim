-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Telescope (file finder)
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Themes
  use({ "rose-pine/neovim", as = "rose-pine" })
  use 'folke/tokyonight.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }

  -- UI & Icons
  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' }
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' }
  }

  -- Utilities
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup({}) end
  }
  use {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end
  }
  use { 'nvim-lua/plenary.nvim' }
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require('todo-comments').setup() end
  }
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('ThePrimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')

  -- LSP Support
  use("neovim/nvim-lspconfig")
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  -- Autocompletion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  -- Mason Setup
  use({
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  })

  -- Mason LSP Config (manage servers like PHP/Python/Lua here)
  use({
    "williamboman/mason-lspconfig.nvim",
    after = "mason.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- DO NOT put "dartls" here. flutter-tools handles it.
        ensure_installed = { "intelephense", "lua_ls" },
        automatic_installation = true,
      })
    end,
  })

  -- === THIS IS THE FIX FOR DART ===
  -- automatic dart/flutter lsp configuration
  use {
    'nvim-flutter/flutter-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require("flutter-tools").setup({
        lsp = {
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
          -- This flag prevents the crash by slowing down updates slightly
                    flags = {
                        allow_incremental_sync = false, -- This allows cmp and autopairs to work safely
                        debounce_text_changes = 500,         },
        }
      })
    end
  }

  -- Manual LSP Setup for other languages (PHP, Lua, etc)
  use({
    "neovim/nvim-lspconfig",
    after = "mason-lspconfig.nvim",
    config = function()
      local caps = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      -- PHP
      lspconfig.intelephense.setup({ capabilities = caps })

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = caps,
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      })
    end,
  })
    -- In your packer startup function
use {
    'akinsho/flutter-tools.nvim',
    requires = {
        'nvim-lua/plenary.nvim',
        'mfussenegger/nvim-dap', -- Essential for debugging
    }
}
    use 'onsails/lspkind.nvim'
    use "rafamadriz/friendly-snippets"

end)
