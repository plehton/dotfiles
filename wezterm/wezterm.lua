local wezterm = require 'wezterm'
local config = require 'wezterm'.config_builder()

-- Set up dynamic switching of colorscheme:
--
-- ~/.colorscheme contains the name of the colorscheme which is shared
-- with other apps, especially neovim. Alacritty and Kitty can be easily
-- configured to share the same colorscheme names. Since Wezterm has it's
-- own colorsceme database, we need to create a mapping for the names.

local colorscheme_file = os.getenv("HOME") .. "/.colorscheme"
wezterm.add_to_config_reload_watch_list(colorscheme_file)

local COLORSCHEMES = {
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

local get_colorscheme_name = function(cf)
    local file = io.open(cf, "r")
    if file then
        local scheme = file:read("*l")
        scheme = COLORSCHEMES[scheme]
        file:close()
    end
end

--
-- Do the actual configuration
--
config = {
    font = wezterm.font('JetBrains Mono', { weight = 'Thin' }),
    font_size = 16,
    window_decorations = "RESIZE",
    enable_tab_bar = false,
    adjust_window_size_when_changing_font_size = false,
    color_scheme = get_colorscheme_name(colorscheme_file),
    window_padding = {
        left = 10,
        right = 10,
        top = 10,
        bottom = 10,
    },
    keys = {}
}

return config
