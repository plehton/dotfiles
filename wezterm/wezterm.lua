local wezterm = require 'wezterm'
local config = require'wezterm'.config_builder()

config.color_scheme = 'rose-pine'

config.font = wezterm.font('JetBrains Mono', { weight = 'Light' })
config.font_size = 15

config.enable_tab_bar = false

config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}

config.keys = {
    -- We don't want to use tabs while we are in tmux world
    { key = 'T', mods = 'CTRL', action =  wezterm.action.DisableDefaultAssignment },
    { key = 'T', mods = 'SHIFT|CTRL', action =  wezterm.action.DisableDefaultAssignment },
    { key = 't', mods = 'SHIFT|CTRL', action =  wezterm.action.DisableDefaultAssignment },
    { key = 't', mods = 'SUPER', action = wezterm.action.DisableDefaultAssignment },
}

return config
