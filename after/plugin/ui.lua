-- after/plugin/ui_style.lua

-- 1. Force the Border Style for ALL popups
local border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = border,
    max_width = 80,
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = border,
  }
)

vim.diagnostic.config({
  float = { border = border },
})

-- 2. Fix the Colors (Crucial!)
-- This forces the popup to have a dark grey background so it stands out
-- and ensures the border is visible.
vim.cmd([[
  highlight NormalFloat guibg=#1f2335
  highlight FloatBorder guifg=#3d59a1 guibg=#1f2335
  highlight Pmenu guibg=#1f2335
  highlight PmenuSel guibg=#3d59a1 guifg=white
]])
