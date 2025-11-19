vim.g.mapleader = " "
-- Helper function to run commands in a new terminal split
local function run_in_terminal(cmd)
  -- Open a new 10-line horizontal split
  -- Run the command in a terminal inside that split
  vim.cmd("10split | terminal " .. cmd)
  -- Automatically enter insert mode in the terminal
  vim.api.nvim_command("startinsert")
end
vim.keymap.set("n", "<leader>pv", ":NvimTreeToggle<CR>", { desc = "Explorer" })
vim.g.mapleader = " "
-- Run current file depending on filetype (<leader>r)
vim.keymap.set("n", "<leader>r", function()
  vim.cmd("w") -- save before run
  local ft = vim.bo.filetype
  local file = vim.fn.expand("%")
  local name = vim.fn.expand("%:r")
  local cmd = "" -- Variable to hold the command

  if ft == "python" then
    cmd = "python3 " .. file
  elseif ft == "c" then
    -- Compile, then clear terminal, then run
    cmd = "gcc " .. file .. " -o " .. name .. " && clear && ./" .. name
  elseif ft == "cpp" then
    -- Compile, then clear terminal, then run
    cmd = "g++ " .. file .. " -o " .. name .. " && clear && ./" .. name
  elseif ft == "dart" then
    cmd = "dart run " .. file
  elseif ft == "java" then
    -- Compile, then clear terminal, then run
    cmd = "javac " .. file .. " && clear && java " .. name
  else
    print("No run command for filetype: " .. ft)
    return -- Stop if no command
  end

  -- Run the constructed command in our new terminal function
  if cmd ~= "" then
    run_in_terminal(cmd)
  end
end, { desc = "Run current file" })
-- Make gg always go to absolute first line
vim.keymap.set("n", "gg", "gg0", { noremap = true })

-- Make G always go to absolute last line
vim.keymap.set("n", "G", "G$", { noremap = true })
-- Exit insert mode and move one character to the right
vim.keymap.set("i", "<Esc>", "<Esc>l", { noremap = true, silent = true })
-- ~/.config/nvim/after/plugin/motions.lua
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
-- 's' = search and jump
vim.keymap.set('n', 's', function()
  local pat = vim.fn.input("Jump to: ")
  if pat ~= "" then
    vim.fn.search(pat, "W")     -- move to first match
    vim.fn.setreg('/', pat)     -- store pattern for ; and ,
  end
end, { noremap = true, silent = true })

-- Only in normal mode (no completion conflict)
map("n", "<C-j>", "<C-d>", opts) -- half-page down
map("n", "<C-k>", "<C-u>", opts) -- half-page up
vim.keymap.set("n", "gg", "gg0", { noremap = true, silent = true })
vim.keymap.set("n", "G", "G$", { noremap = true, silent = true })
vim.keymap.set("v", "gg", "gg0", { noremap = true, silent = true })
vim.keymap.set("v", "G", "G$", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>s', require('telescope.builtin').current_buffer_fuzzy_find, { desc = 'Search in Current File' })
vim.keymap.set('n', '<leader>pS', require('telescope.builtin').live_grep, { desc = 'Search Project (Grep)' })
