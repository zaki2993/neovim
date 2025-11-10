local ok, mason = pcall(require, "mason")
if not ok then
  vim.notify("mason not found", vim.log.levels.ERROR); return
end

mason.setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",        -- C/C++
    "jdtls",         -- Java
    "pyright",       -- Python
    "intelephense",  -- PHP
    "lua_ls",        -- Lua (for nvim config)
  },
})

