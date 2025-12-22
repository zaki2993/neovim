-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Ensure truecolor
vim.opt.termguicolors = true

-- Key mapping for ESC inside the tree
vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    vim.keymap.set("n", "<Esc>", ":NvimTreeClose<CR>", { buffer = true, silent = true })
  end,
})

-- Setup
require('nvim-tree').setup({
  hijack_netrw = true,
  sort_by = "case_sensitive",
  
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  
  -- UPDATE HERE: Added numbers
  view = { 
    width = 34, 
    side = "left",
    number = true,         -- Shows absolute line numbers
    relativenumber = true, -- Shows relative numbers (great for jumping)
  },

  renderer = {
    group_empty = true,
    icons = {
      show = { file = true, folder = true, folder_arrow = true, git = true },
    },
  },
  filters = { dotfiles = false },
  git = { enable = true, ignore = false },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = { hint = "", info = "", warning = "", error = "" },
  },
  update_focused_file = { enable = true, update_root = true },
})

-- Force Transparent Background
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })

-- Keymaps
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'File tree: toggle' })
vim.keymap.set('n', '<leader>o', ':NvimTreeFocus<CR>',  { desc = 'File tree: focus' })
vim.keymap.set('n', '<leader>fe', ':NvimTreeFindFile<CR>', { desc = 'File tree: reveal current file' })

-- UPDATE HERE: New keymap to collapse all folders
vim.keymap.set('n', '<leader>ee', require('nvim-tree.api').tree.collapse_all, { desc = 'Collapse all folders' })

-- Open tree when starting on a directory
local function open_nvim_tree(data)
  if vim.fn.isdirectory(data.file) ~= 1 then return end
  vim.cmd.cd(data.file)
  require('nvim-tree.api').tree.open()
end
vim.api.nvim_create_autocmd("VimEnter", { callback = open_nvim_tree })
