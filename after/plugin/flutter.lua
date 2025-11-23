require("flutter-tools").setup {
  ui = {
    -- Adds a nice border to hover windows
    border = "rounded",
  },
  decorations = {
    statusline = {
      app_version = true,
      device = true,
    }
  },
  -- This configures the LSP for you
  lsp = {
    on_attach = function(client, bufnr)
      -- Re-use your standard on_attach function here if you have one exported,
      -- otherwise, map your keys here specifically for dart.
      local opts = { buffer = bufnr, remap = false }
      
      -- Essential Flutter Keybinds
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    end,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  },
  debugger = {
    enabled = true,
    register_configurations = function(paths)
      require("dap").configurations.dart = {
        {
          type = "dart",
          request = "launch",
          name = "Launch Flutter",
          dartSdkPath = paths.dart_sdk,
          flutterSdkPath = paths.flutter_sdk,
          program = "${workspaceFolder}/lib/main.dart",
          cwd = "${workspaceFolder}",
        }
      }
    end,
  }
}
