-- State tracking
local state = {
  win = -1,
  buf = -1
}
local last_cmd = nil

local function open_floating_term()
  -- 1. If window exists, close it first to avoid duplicates
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end

  -- 2. Create a fresh scratch buffer for the new terminal
  state.buf = vim.api.nvim_create_buf(false, true)

  -- 3. Calculate dimensions
  local width  = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row    = math.floor((vim.o.lines - height) / 2)
  local col    = math.floor((vim.o.columns - width) / 2)

  -- 4. Open the window using the FRESH buffer
  state.win = vim.api.nvim_open_win(state.buf, true, {
    relative = "editor",
    style = "minimal",
    border = "rounded",
    width = width,
    height = height,
    row = row,
    col = col,
  })
end

local function run_cmd(cmd)
  last_cmd = cmd
  open_floating_term()
  -- Run the command in the new buffer
  vim.cmd("terminal " .. cmd)
  vim.cmd("startinsert")
end

-- Smart code runner
vim.keymap.set("n", "<leader>r", function()
  vim.cmd("w")

  local ft   = vim.bo.filetype
  local file = vim.fn.expand("%")
  local dir  = vim.fn.fnamemodify(file, ":h")
  local tail = vim.fn.fnamemodify(file, ":t")
  local base = vim.fn.fnamemodify(file, ":t:r")
  local cmd

  if ft == "python" then
    cmd = "cd " .. vim.fn.fnameescape(dir) .. " && python3 " .. vim.fn.fnameescape(tail)
  elseif ft == "c" then
    cmd = "cd " .. vim.fn.fnameescape(dir) .. " && gcc " .. vim.fn.fnameescape(tail) .. " -o " .. base .. " && ./" .. base
  elseif ft == "cpp" then
    cmd = "cd " .. vim.fn.fnameescape(dir) .. " && g++ -std=c++17 " .. vim.fn.fnameescape(tail) .. " -o " .. base .. " && ./" .. base
  elseif ft == "java" then
    local pkg
    local lines = vim.api.nvim_buf_get_lines(0, 0, math.min(100, vim.api.nvim_buf_line_count(0)), false)
    for _, l in ipairs(lines) do
      local m = string.match(l, "^%s*package%s+([%w_%.]+)%s*;")
      if m then pkg = m; break end
    end
    local fqcn = pkg and (pkg .. "." .. base) or base
    cmd = "cd " .. vim.fn.fnameescape(dir) .. " && javac -d . " .. vim.fn.fnameescape(tail) .. " && java -cp . " .. fqcn
  
  elseif ft == "php" then
    local is_test = string.match(tail, "Test%.php$") or string.match(tail, "_test%.php$")
    local has_phpunit = vim.fn.filereadable(vim.fn.fnamemodify(dir .. "/vendor/bin/phpunit", ":p")) == 1
    if is_test and has_phpunit == 1 then
      cmd = "cd " .. vim.fn.fnameescape(dir) .. " && ./vendor/bin/phpunit --colors=always " .. vim.fn.fnameescape(tail)
    else
      cmd = "cd " .. vim.fn.fnameescape(dir) .. " && php " .. vim.fn.fnameescape(tail)
    end

  elseif ft == "dart" then
    local pubspec = vim.fs.find("pubspec.yaml", { upward = true, path = dir })[1]
    local is_flutter = false
    if pubspec then
      local f = io.open(pubspec, "r")
      if f then
        local content = f:read("*a")
        f:close()
        if content:match("sdk:%s*flutter") or content:match("flutter:") then
          is_flutter = true
        end
      end
    end

    if is_flutter then
      local project_root = vim.fn.fnamemodify(pubspec, ":h")
      cmd = "cd " .. vim.fn.fnameescape(project_root) .. " && flutter run -d linux"
    else
      cmd = "cd " .. vim.fn.fnameescape(dir) .. " && dart run " .. vim.fn.fnameescape(tail)
    end

  else
    vim.notify("No runner for filetype: " .. ft)
    return
  end

  run_cmd(cmd)
end, { desc = "Run current file" })

-- Re-run last
vim.keymap.set("n", "<leader>R", function()
  if last_cmd then run_cmd(last_cmd) end
end, { desc = "Re-run last command" })

-- Close terminal on Escape
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:close<CR>", { buffer = true, silent = true })
  end,
})
