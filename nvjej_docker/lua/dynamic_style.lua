local M = {}

-- Preset configurations
local presets = {
  ["Default"] = {
    column_width = 120,
    line_endings = "Unix",
    indent_type = "Spaces",
    indent_width = 2,
    quote_style = "AutoPreferDouble",
    call_parentheses = "None",
	cursorline = true,
	signcolumn = "yes",
	scrolloff = 8,
	history = 200,
	foldmethod = "manual",
  },
  ["C/C++"] = {
    column_width = 120,
    line_endings = "Unix",
    indent_type = "Tabs",   -- noexpandtab => use Tabs
	expandtab = false,
    tabstop = 4,
    shiftwidth = 4,
    quote_style = "AutoPreferDouble",
    call_parentheses = "None",
	cursorline = true,
	signcolumn = "yes",
	scrolloff = 8,
	history = 200,
	foldmethod = "manual",
  },
}

-- Apply the given configuration by writing it to a temporary file.
function M.apply_config(config)
  local config_file = vim.fn.stdpath('cache') .. '/dynamic_stylua.toml'
  local f = io.open(config_file, "w")
  if f then
    for k, v in pairs(config) do
      -- Check if the value is numeric or string.
      if tonumber(v) then
        f:write(string.format("%s = %s\n", k, v))
      else
        f:write(string.format("%s = \"%s\"\n", k, v))
      end
    end
    f:close()
    vim.notify("Dynamic Stylua config applied: " .. config_file)
    -- Here you can trigger a reload for your formatter integration if needed.
  else
    vim.notify("Failed to write dynamic stylua config", vim.log.levels.ERROR)
  end
end

-- Helper to prompt the user for manual overrides
function M.manual_override(callback)
  local new_config = {}
  local keys = {"column_width", "line_endings", "indent_type", "indent_width", "quote_style", "call_parentheses", "tabstop", "shiftwidth"}
  local i = 1

  local function ask_next()
    if i > #keys then
      callback(new_config)
      return
    end
    local key = keys[i]
    vim.ui.input({ prompt = "Enter value for " .. key .. " (or leave blank to skip): " }, function(input)
      if input and input ~= "" then
        new_config[key] = input
      end
      i = i + 1
      ask_next()
    end)
  end

  ask_next()
end

-- Opens the UI for selecting the Stylua configuration
function M.open_ui()
  local choices = {"Default", "C/C++", "Manual Override"}
  vim.ui.select(choices, { prompt = "Choose Stylua configuration:" }, function(choice)
    if not choice then return end
    if choice == "Manual Override" then
      M.manual_override(function(config)
        M.apply_config(config)
      end)
    else
      local config = presets[choice]
      M.apply_config(config)
    end
  end)
end

-- Create a user command for easy access
vim.api.nvim_create_user_command("DynamicStylua", function()
  M.open_ui()
end, {})

return M
