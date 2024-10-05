local wezterm = require 'wezterm'
local config = require 'wezterm'.config_builder()

local DEFAULT_COLORSCHEME = "rose-pine"


-- local gpus = wezterm.gui.enumerate_gpus()
-- config.webgpu_preferred_adapter = gpus[1]
-- config.front_end = "WebGpu"

config.font = wezterm.font('JetBrains Mono', { weight = 'Light' })
config.font_size = 15

config.enable_tab_bar = true

config.window_padding = {
    left = 2,
    right = 2,
    top = 2,
    bottom = 2,
}

config.keys = {
    -- We don't want to use tabs while we are in tmux world
    { key = 'T', mods = 'CTRL',       action = wezterm.action.DisableDefaultAssignment },
    { key = 'T', mods = 'SHIFT|CTRL', action = wezterm.action.DisableDefaultAssignment },
    { key = 't', mods = 'SHIFT|CTRL', action = wezterm.action.DisableDefaultAssignment },
    { key = 't', mods = 'SUPER',      action = wezterm.action.DisableDefaultAssignment },
}

-- Colorscheme
--
local colorscheme_file = os.getenv("HOME") .. "/.colorscheme"
wezterm.add_to_config_reload_watch_list(colorscheme_file)

local colorschemes = require("colorschemes")

local file = io.open(colorscheme_file, "r")
if file then
    local scheme = file:read("*l")
    scheme = colorschemes[scheme]
    config.color_scheme = scheme ~= nil and scheme or DEFAULT_COLORSCHEME
    wezterm.log_info(config.color_scheme)
    file:close()
end

return config
