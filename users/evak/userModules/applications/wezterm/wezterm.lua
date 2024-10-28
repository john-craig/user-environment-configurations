local wezterm = require 'wezterm'

local config = wezterm.config_builder()

--config.enable_wayland = false

config.color_scheme = 'Tokyo Night'

config.keys = {
    { key = 'LeftArrow', mods = 'CTRL|SHIFT', action =  wezterm.action.DisableDefaultAssignment, },
    { key = 'RightArrow', mods = 'CTRL|SHIFT', action =  wezterm.action.DisableDefaultAssignment, },
    { key = 'X', mods = 'CTRL', action = wezterm.action.DisableDefaultAssignment, },
  }

return config
