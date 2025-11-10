local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    -- Navigate suggestions
    ["<M-n>"] = cmp.mapping.select_next_item(),   -- Alt+n
    ["<M-p>"] = cmp.mapping.select_prev_item(),   -- Alt+p

    -- Confirm selection
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })            -- accept highlighted (or first) item
      else
        fallback()                                -- insert a literal Tab
      end
    end, { "i", "s" }),

    -- (Optional) open menu manually
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})

