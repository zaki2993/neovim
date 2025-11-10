-- after/plugin/replace.lua

-- Use safer delimiter than '/'
local SUB_DELIM = "#"

local function esc_find(s)
  s = s or ""
  -- \V = very nomagic, treat pattern literally
  return "\\V" .. s:gsub(SUB_DELIM, "\\" .. SUB_DELIM)
end

local function esc_repl(s)
  s = s or ""
  -- In replacement, & = whole match -> must escape
  s = s:gsub("&", "\\&")
  -- Also escape our delimiter
  return s:gsub(SUB_DELIM, "\\" .. SUB_DELIM)
end

local function word_under_cursor()
  local w = vim.fn.expand("<cword>")
  return (w and w ~= "") and w or ""
end

local function fallback_select(items, opts, on_choice)
  local lines = { (opts and opts.prompt) or "Choose:" }
  for i, it in ipairs(items) do lines[#lines+1] = string.format("%d) %s", i, it) end
  local idx = vim.fn.inputlist(lines)
  on_choice(items[idx], idx)
end

local function fallback_input(opts, on_done)
  local ans = vim.fn.input(((opts and opts.prompt) or "") .. " ")
  on_done(ans ~= "" and ans or nil)
end

local function resolve_range(scope_hint, ui_select)
  local scopes = {
    "Selection (visual)  →  '<,'>",
    "Current line        →  .",
    "From here to end    →  .,$",
    "Whole file          →  %",
  }
  local scope_map = {
    ["Selection (visual)  →  '<,'>"] = "'<,'>",
    ["Current line        →  ."]      = ".",
    ["From here to end    →  .,$"]    = ".,$",
    ["Whole file          →  %"]      = "%",
  }

  -- Accept raw ranges directly
  if scope_hint == "'<,'>" or scope_hint == "." or scope_hint == ".,$" or scope_hint == "%" then
    return scope_hint
  end
  -- Accept labels
  if scope_hint and scope_map[scope_hint] then
    return scope_map[scope_hint]
  end

  -- Ask user
  local chosen
  (ui_select or fallback_select)(scopes, { prompt = "Scope ›" }, function(choice)
    chosen = scope_map[choice]
  end)
  return chosen
end

local function smart_replace(scope_hint)
  local ui_select = vim.ui.select or fallback_select
  local ui_input  = vim.ui.input  or fallback_input

  -- 1) find
ui_input({ prompt = "Find ›", default = "" }, function(find)
    -- 2) replacement
    ui_input({ prompt = "Replace with ›", default = "" }, function(repl)
      if repl == nil then return end

      -- 3) scope
      local range = resolve_range(scope_hint, ui_select)
      if not range then return end

      -- Selection scope requires visual mode
      if range == "'<,'>" and vim.fn.mode():lower():sub(1,1) ~= "v" then
        vim.notify("Tip: select lines first (V … movement), then <leader>q.", vim.log.levels.WARN)
        return
      end

      -- 4) confirm option
      local chosen_conf
      ui_select({ "No confirm (faster)", "Confirm each (safer)" }, { prompt = "Confirmation ›" }, function(conf)
        chosen_conf = conf
      end)
      if not chosen_conf then return end
      local flags = (chosen_conf == "Confirm each (safer)") and "gc" or "g"

      -- Build tight command: :{range}s#{find}#{repl}#{flags}
      local cmd = string.format(":%ss%s%s%s%s%s",
        range,
        SUB_DELIM,
        esc_find(find),
        SUB_DELIM,
        esc_repl(repl),
        SUB_DELIM .. flags
      )

      -- Uncomment this to debug the exact command:
      -- vim.notify(cmd)

      vim.cmd(cmd)
    end)
  end)
end

-- Keymaps
-- Normal: menu
vim.keymap.set("n", "<leader>q", function()
  smart_replace()
end, { desc = "Smart Replace (menu)" })

-- Normal: here → end (fast path)
vim.keymap.set("n", "<leader>Q", function()
  smart_replace(".,$")
end, { desc = "Smart Replace (here → end)" })

-- Visual: selection only
vim.keymap.set("x", "<leader>q", function()
  smart_replace("'<,'>")
end, { desc = "Smart Replace (visual selection)" })

