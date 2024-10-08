local wezterm = require 'wezterm'
local config = require 'wezterm'.config_builder()

config.font = wezterm.font('JetBrains Mono', { weight = 'Regular' })
config.font_size = 15

config.window_decorations = "RESIZE"
config.enable_tab_bar = false

config.window_padding = {
    left = 1,
    right = 1,
    top = 1,
    bottom = 1,
}

config.keys = {}

-- Colorscheme
local colorscheme_file = os.getenv("HOME") .. "/.colorscheme"
wezterm.add_to_config_reload_watch_list(colorscheme_file)

local colorschemes = require("colorschemes")

local file = io.open(colorscheme_file, "r")
if file then
    local scheme = file:read("*l")
    scheme = colorschemes[scheme]
    config.color_scheme = scheme
    file:close()
end

return config
