-- capabilities (for nvim-cmp)
local caps = require("cmp_nvim_lsp").default_capabilities()

-- 1) Define configs
vim.lsp.config('clangd',       { capabilities = caps })            -- C/C++
vim.lsp.config('pyright',      { capabilities = caps })            -- Python
vim.lsp.config('jdtls',        { capabilities = caps })            -- Java
vim.lsp.config('intelephense', { capabilities = caps })            -- PHP
vim.lsp.config('lua_ls', {
  capabilities = caps,
  settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})
-- We set a 1-second debounce so the server doesn't choke on fast typing

-- 2) Enable them (start on matching filetypes)
vim.lsp.enable({
  'clangd',
  'pyright',
  'jdtls',
  'intelephense',
  'lua_ls',
})

-- ... existing diagnostic config ...
