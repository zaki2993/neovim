-- after/plugin/comment.lua
local ok, Comment = pcall(require, "Comment")
if not ok then return end
Comment.setup({})

-- Use the plugin's <Plug> maps for speed and correctness
-- Current line toggle
vim.keymap.set("n", "<leader>c", "<Plug>(comment_toggle_linewise_current)", {
  desc = "Comment: toggle current line",
  remap = true,
})

-- Operator-pending: <leader>cc then motion (5j, 8k, }, ip, etc.)
vim.keymap.set("n", "<leader>cc", "<Plug>(comment_toggle_linewise)", {
  desc = "Comment: operator then motion",
  remap = true,
})

-- Visual: select then <leader>c
vim.keymap.set("x", "<leader>c", "<Plug>(comment_toggle_linewise_visual)", {
  desc = "Comment: toggle selection",
  remap = true,
})

-- Optional block comments
vim.keymap.set("n", "<leader>cb", "<Plug>(comment_toggle_blockwise_current)", {
  desc = "Comment: block current",
  remap = true,
})
vim.keymap.set("x", "<leader>cb", "<Plug>(comment_toggle_blockwise_visual)", {
  desc = "Comment: block selection",
  remap = true,
})

