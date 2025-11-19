-- This is now ~/.config/nvim/after/plugin/colors.lua

-- 1. Configure Catppuccin
require("catppuccin").setup({
  flavour = "macchiato", -- or frappe, latte, mocha
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

vim.cmd.colorscheme("catppuccin-macchiato")

-- 3. (Optional) Lock background colors if you want consistency
-- The catppuccin theme already does this, but this makes it explicit.
-- You might not even need these lines.
vim.cmd("hi Normal guibg=none")
vim.cmd("hi NormalNC guibg=none")
vim.cmd("hi CursorLine guibg=none")

