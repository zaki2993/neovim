vim.cmd.colorscheme("catppuccin-macchiato")

require("catppuccin").setup({
  flavour = "macchiato", -- calm dark navy
  transparent_background = false,
  integrations = {
    lualine = true,
    treesitter = true,
    cmp = true,
    gitsigns = true,
    telescope = true,
    indent_blankline = true,
    native_lsp = {
      enabled = true,
      inlay_hints = { background = true },
    },
  }
})

-- Soft cursor line so eyes don’t jump too much
vim.cmd("highlight CursorLine guibg=#24273a")

