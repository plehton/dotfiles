local wezterm = require 'wezterm'
local config = require 'wezterm'.config_builder()

local colorschemes = {
    ["catppuccin-frappe"]    = "Catppuccin Frappe",
    ["catppuccin-latte"]     = "Catppuccin Latte",
    ["catppuccin-macchiato"] = "Catppuccin Macchiato",
    ["catppuccin-mocha"]     = "Catppuccin Mocha",
    ["kanagawa-dragon"]      = "Kanagawa Dragon",
    ["kanagawa-lotus"]       = "Kanagawa Lotus",
    ["kanagawa-wave"]        = "Kanagawa Wave",
    ["rose-pine-dawn"]       = "rose-pine-dawn",
    ["rose-pine-main"]       = "rose-pine",
    ["rose-pine-moon"]       = "rose-pine-moon",
    ["tokyonight-day"]       = "Tokyo Night Day",
    ["tokyonight-moon"]      = "Tokyo Night Moon",
    ["tokyonight-night"]     = "Tokyo Night",
    ["tokyonight-storm"]     = "Tokyo Night Storm",
}

config.front_end = 'WebGpu'

config.font = wezterm.font('FiraCode', { weight = 'Regular' })
config.font_size = 15

config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.adjust_window_size_when_changing_font_size = false

config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
}

config.keys = {}

local colorscheme_file = os.getenv("HOME") .. "/.colorscheme"
wezterm.add_to_config_reload_watch_list(colorscheme_file)

local file = io.open(colorscheme_file, "r")
if file then
    local scheme = file:read("*l")
    scheme = colorschemes[scheme]
    config.color_scheme = scheme
    file:close()
end

return config
