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
  use( {
   "rose-pine/neovim",
   as = "rose-pine",
})
  use 'folke/tokyonight.nvim'
  use {
  'nvim-tree/nvim-tree.lua',
  requires = { 'nvim-tree/nvim-web-devicons' }  -- icons
}
use {
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons' }
}
use {
  "windwp/nvim-autopairs",
  config = function()
    require("nvim-autopairs").setup({})
  end
}
use {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup()
  end
}
use { 'nvim-lua/plenary.nvim' }
use {
  'folke/todo-comments.nvim',
  requires = 'nvim-lua/plenary.nvim',
  config = function() require('todo-comments').setup() end
}

use { "catppuccin/nvim", as = "catppuccin" }
  use('nvim-treesitter/nvim-treesitter' ,{run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('ThePrimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use("neovim/nvim-lspconfig")
use("williamboman/mason.nvim")
use("williamboman/mason-lspconfig.nvim")

use("hrsh7th/nvim-cmp")
use("hrsh7th/cmp-nvim-lsp")
use("hrsh7th/cmp-buffer")
use("hrsh7th/cmp-path")
use("L3MON4D3/LuaSnip")
use("saadparwaiz1/cmp_luasnip")

-- Snippets for PHP
use("rafamadriz/friendly-snippets")

-- Mason core
use({
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup()
  end,
})

-- Install Intelephense via Mason
use({
  "williamboman/mason-lspconfig.nvim",
  after = "mason.nvim",
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = { "intelephense" },
      automatic_installation = true,
    })
  end,
})

-- LSP config for PHP
use({
  "neovim/nvim-lspconfig",
  after = "mason-lspconfig.nvim",
  config = function()
    local caps = require("cmp_nvim_lsp").default_capabilities()
    require("lspconfig").intelephense.setup({ capabilities = caps })
  end,
})


end)

