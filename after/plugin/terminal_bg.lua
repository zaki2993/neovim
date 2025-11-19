-- Always match terminal background
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.cmd("highlight Normal        guibg=none")
    vim.cmd("highlight NormalNC      guibg=none")
    vim.cmd("highlight NormalFloat   guibg=none")
    vim.cmd("highlight FloatBorder   guibg=none")
    vim.cmd("highlight SignColumn    guibg=none")
    vim.cmd("highlight LineNr        guibg=none")
    vim.cmd("highlight CursorLine    guibg=none")
    vim.cmd("highlight CursorColumn  guibg=none")
  end
})

-- Also apply immediately on startup
vim.cmd("highlight Normal        guibg=none")
vim.cmd("highlight NormalNC      guibg=none")
vim.cmd("highlight NormalFloat   guibg=none")
vim.cmd("highlight FloatBorder   guibg=none")
vim.cmd("highlight SignColumn    guibg=none")
vim.cmd("highlight LineNr        guibg=none")
vim.cmd("highlight CursorLine    guibg=none")
vim.cmd("highlight CursorColumn  guibg=none")
-- ensure terminal background everywhere (files explorers, telescope, floats...)
local groups = {
  -- nvim-tree / file explorers
  "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeEndOfBuffer", "NvimTreeVertSplit", "NvimTreeRootFolder",
  -- telescope
  "TelescopeNormal", "TelescopePromptNormal", "TelescopeResultsNormal", "TelescopePreviewNormal",
  "TelescopeBorder", "TelescopePromptBorder", "TelescopeResultsBorder", "TelescopePreviewBorder",
  -- floating windows / builtin
  "NormalFloat", "FloatBorder", "SignColumn", "CursorLine", "CursorColumn", "LineNr",
  -- treesitter / indent / lsp UI
  "IndentBlanklineChar", "IndentBlanklineContextChar",
  "NvimTreeCursorLine", "WhichKeyFloat", "WhichKey",
  -- buffers / statusline splits
  "VertSplit", "StatusLine", "StatusLineNC",
  -- common plugin UI
  "CmpNormal", "CmpPum", "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb",
  -- bufferline/tabline
  "BufferLineBackground", "BufferLineBuffer", "BufferLineTab",
}

local function clear_bgs()
  for _, g in ipairs(groups) do
    pcall(vim.api.nvim_set_hl, 0, g, { bg = "none" })
  end
  -- also make sure Normal/NormalNC are cleared
  pcall(vim.api.nvim_set_hl, 0, "Normal", { bg = "none" })
  pcall(vim.api.nvim_set_hl, 0, "NormalNC", { bg = "none" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function() clear_bgs() end
})

-- apply immediately (for the current session)
clear_bgs()

