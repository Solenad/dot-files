local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

local bar_url = "https://github.com/adriankarlen/bar.wezterm"
local success, bar = pcall(wezterm.plugin.require, bar_url)

-- 2. PLUGIN SETTINGS
local bar_settings = {
  position = "bottom",
  max_width = 32,
  padding = { left = 1, right = 1, tabs = { left = 0, right = 2 } },
  separator = {
    space = 1,
    left_icon = wezterm.nerdfonts.fa_long_arrow_right,
    right_icon = wezterm.nerdfonts.fa_long_arrow_left,
    field_icon = wezterm.nerdfonts.indent_line,
  },
  modules = {
    tabs = {
      active_tab_fg = 4,
      active_tab_bg = "transparent",
      inactive_tab_fg = 6,
      inactive_tab_bg = "transparent",
      new_tab_fg = 2,
      new_tab_bg = "transparent",
    },
    workspace = { enabled = true, icon = wezterm.nerdfonts.cod_window, color = 8 },
    leader = { enabled = true, icon = wezterm.nerdfonts.oct_rocket, color = 2 },
    pane = { enabled = true, icon = wezterm.nerdfonts.cod_multiple_windows, color = 7 },
    username = { enabled = true, icon = wezterm.nerdfonts.fa_user, color = 6 },
    hostname = { enabled = true, icon = wezterm.nerdfonts.cod_server, color = 8 },
    clock = { enabled = true, icon = wezterm.nerdfonts.md_calendar_clock, format = "%H:%M", color = 5 },
    cwd = { enabled = true, icon = wezterm.nerdfonts.oct_file_directory, color = 7 },
  },
}

-- Apply plugin ONLY if it was successfully required
-- if success and bar then
--   bar.apply_to_config(config, bar_settings)
-- else
--   -- If it fails, it will print why to the WezTerm log instead of crashing
--   wezterm.log_error("Plugin load failed: " .. tostring(bar))
-- end

-- 3. BASIC SETTINGS
config.front_end = "WebGpu" -- If it still crashes, change this to "Software" to test
config.win32_system_backdrop = 'Disable'
config.window_background_opacity = 0.85
config.color_scheme = 'Catppuccin Macchiato'
config.font_size = 11
config.initial_cols = 110
config.initial_rows = 28
config.default_prog = { 'pwsh.exe' }

-- 4. APPEARANCE & TABS
config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

wezterm.on('update-status', function(window, pane)
  -- 1. Safety Guard: If the window or pane aren't ready, do nothing.
  if not window or not pane then
    return
  end

  -- 2. Wrap the process check in a pcall (Protected Call)
  -- This prevents a crash even if get_foreground_process_name() fails
  local success, process_name = pcall(function()
    return pane:get_foreground_process_name()
  end)

  -- 3. If we couldn't get the process name, just reset and exit
  if not success or not process_name then
    window:set_config_overrides(nil)
    return
  end

  -- 4. Clean up the process name for comparison
  process_name = process_name:match("([^/\\]+)$")
  if process_name then
    process_name = process_name:lower()
  end

  -- 5. Check against your list
  local hide_bar_for_apps = { 'nvim.exe', 'nvim', 'vim', 'vim.exe', 'opencode', 'opencode.exe', 'code.exe' }
  local should_hide = false

  for _, app in ipairs(hide_bar_for_apps) do
    if process_name == app then
      should_hide = true
      break
    end
  end

  -- 6. Apply overrides safely
  local overrides = window:get_config_overrides() or {}
  if should_hide then
    if overrides.enable_tab_bar ~= false then
      window:set_config_overrides({ enable_tab_bar = false })
    end
  else
    if overrides.enable_tab_bar == false then
      window:set_config_overrides(nil)
    end
  end
end)

local function is_vim(pane)
  -- Checks if the current process is vim or nvim
  return pane:get_foreground_process_name():find('n?vim') ~= nil
end

wezterm.on('update-status', function(window, pane)
  if is_vim(pane) then
    -- Send raw Ctrl+V to Neovim
    window:perform_action(wezterm.action.SendKey { key = 'v', mods = 'CTRL' }, pane)
  end
end)
return config
