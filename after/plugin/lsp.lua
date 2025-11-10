-- capabilities (for nvim-cmp)
local caps = require("cmp_nvim_lsp").default_capabilities()

-- 1) Define configs
vim.lsp.config('clangd',        { capabilities = caps })            -- C/C++
vim.lsp.config('pyright',       { capabilities = caps })            -- Python
vim.lsp.config('jdtls',         { capabilities = caps })            -- Java
vim.lsp.config('intelephense',  { capabilities = caps })            -- PHP
vim.lsp.config('lua_ls', {
  capabilities = caps,
  settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})
vim.lsp.config('dartls', { capabilities = caps, cmd = { "dart", "language-server", "--protocol=lsp" } })

-- 2) Enable them (start on matching filetypes)
vim.lsp.enable({
  'clangd',
  'pyright',
  'jdtls',
  'intelephense',
  'lua_ls',
  'dartls',
})
vim.diagnostic.config({
  virtual_text = true,     -- show small inline error text
  signs = true,            -- show the small 'x' on the left
  underline = true,        -- underline error lines
  float = { border = "rounded" }, -- nice border for popup
})
-- Show diagnostic message under cursor
vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float, { desc = "Show error message" })

