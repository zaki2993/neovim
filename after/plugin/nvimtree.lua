-- Disable netrw (prevents conflicts)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Ensure truecolor (you already set this in your opts, keep it)
vim.opt.termguicolors = true
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
  view = { width = 34, side = "left" },
  renderer = {
    group_empty = true,
    icons = {
      show = { file = true, folder = true, folder_arrow = true, git = true },
    },
  },
  filters = { dotfiles = false },
  git = { enable = true, ignore = false }, -- show files even if in .gitignore
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = { hint = "", info = "", warning = "", error = "" },
  },
  update_focused_file = { enable = true, update_root = true },
})

-- Keymaps
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'File tree: toggle' })
vim.keymap.set('n', '<leader>o', ':NvimTreeFocus<CR>',  { desc = 'File tree: focus' })
vim.keymap.set('n', '<leader>fe', ':NvimTreeFindFile<CR>', { desc = 'File tree: reveal current file' })

-- Open tree when starting on a directory
local function open_nvim_tree(data)
  if vim.fn.isdirectory(data.file) ~= 1 then return end
  vim.cmd.cd(data.file)
  require('nvim-tree.api').tree.open()
end
vim.api.nvim_create_autocmd("VimEnter", { callback = open_nvim_tree })
require('nvim-tree').setup({
  view = {
    float = {
      enable = true,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 50,
        height = 30,
        row = 2,
        col = 10,
      },
    },
    width = 50,
  },
  renderer = {
    group_empty = true,
  },
})

