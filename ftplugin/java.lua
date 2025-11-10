-- ~/.config/nvim/ftplugin/java.lua

-- capabilities for nvim-cmp
local caps = require("cmp_nvim_lsp").default_capabilities()

-- Mason jdtls paths
local mason = vim.fn.stdpath("data") .. "/mason"
local jdtls_dir = mason .. "/packages/jdtls"
local launcher = vim.fn.glob(jdtls_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local os_config = jdtls_dir .. "/config_linux"

-- Workspace per project (required by jdtls)
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls_workspaces/" .. project_name

-- Detect project root
local root_dir = vim.fs.root(0, { "pom.xml", "gradlew", "mvnw", ".git" }) or vim.fn.getcwd()

-- Command to run jdtls
local cmd = {
  "java",
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  "-Xms1g",
  "--add-modules=ALL-SYSTEM",
  "--add-opens", "java.base/java.util=ALL-UNNAMED",
  "--add-opens", "java.base/java.lang=ALL-UNNAMED",
  "-jar", launcher,
  "-configuration", os_config,
  "-data", workspace_dir,
}

-- Start/attach using native API (no lspconfig)
vim.lsp.start({
  name = "jdtls",
  cmd = cmd,
  root_dir = root_dir,
  capabilities = caps,
})

