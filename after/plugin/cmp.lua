local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind") -- Import the new plugin

require("luasnip.loaders.from_vscode").lazy_load() -- Optional: Load standard snippets if you have them

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  
  -- 1. Make the window look like VS Code (Rounded borders)
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  -- 2. Add Icons (The VS Code Visuals)
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show icon + text
      maxwidth = 50, 
      ellipsis_char = '...', 
      
      -- Show where the completion is coming from
      menu = ({
        buffer = "[Buf]",
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        path = "[Path]",
      })
    }),
  },

  mapping = cmp.mapping.preset.insert({
    ["<M-n>"] = cmp.mapping.select_next_item(),
    ["<M-p>"] = cmp.mapping.select_prev_item(),
    ["<M-b>"] = cmp.mapping.scroll_docs(-4),
    ["<M-f>"] = cmp.mapping.scroll_docs(4),
    
    -- VS Code uses Enter to confirm, but Tab is fine if you prefer it.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    
    ["<C-Space>"] = cmp.mapping.complete(),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" }, 
  }, {
    { name = "buffer" },
  }),
})
