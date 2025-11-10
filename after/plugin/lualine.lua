local ok, lualine = pcall(require, "lualine")
if not ok then return end

lualine.setup({
  options = {
    theme = "catppuccin",
    icons_enabled = true,
    component_separators = { left = "│", right = "│" },
    section_separators = { left = "", right = "" }, -- no crazy shapes
    globalstatus = true,
  },
})

