-- Highlighting handled by todo-comments.nvim via its setup() above.

-- Insert a new comment line with a tag (e.g., TODO, NOTE) and start typing.
local function insert_tag(tag)
  local cs = vim.bo.commentstring
  if not cs or cs == "" then cs = "# %s" end
  -- Turn "%s" into "TAG: "
  local line = cs:gsub("%%s", tag .. ": ")

  local row = vim.api.nvim_win_get_cursor(0)[1] -- current line number (1-based)
  vim.api.nvim_buf_set_lines(0, row, row, true, { line }) -- insert below current line
  vim.api.nvim_win_set_cursor(0, { row + 1, #line })
  vim.cmd("startinsert")
end

-- Keymaps:
-- <leader>c        -> keep your existing normal comment toggle from Comment.nvim
vim.keymap.set('n', '<leader>cn', function() insert_tag('NOTE') end, { desc = 'Insert NOTE comment' })
vim.keymap.set('n', '<leader>ct', function() insert_tag('TODO') end, { desc = 'Insert TODO comment' })
vim.keymap.set('n', '<leader>cb', function() insert_tag('BUG')  end, { desc = 'Insert BUG comment'  })
vim.keymap.set('n', '<leader>ch', function() insert_tag('HACK') end, { desc = 'Insert HACK comment' })

