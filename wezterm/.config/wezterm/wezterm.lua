local wezterm = require 'wezterm'
local config = require 'wezterm'.config_builder()

-- Set up dynamic switching of colorscheme
--
-- Poll ~/.colorscheme for changes and read the name of
-- the colorscheme from the file.
--
local colorscheme_file = os.getenv("HOME") .. "/.colorscheme"
wezterm.add_to_config_reload_watch_list(colorscheme_file)

local get_colorscheme_name = function(cf)
    local file = io.open(cf, "r")
    if file then
        local scheme = file:read("*l")
        file:close()
        return scheme
    end
    return nil
end

--
-- Do the actual configuration
--
config = {

    front_end = 'WebGpu',

    font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'ExtraLight' }),
    font_size = 16,
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },

    window_decorations = "RESIZE",
    enable_tab_bar = false,
    adjust_window_size_when_changing_font_size = false,
    color_scheme = get_colorscheme_name(colorscheme_file),
    -- color_scheme = "Forestbones_dark",
    window_padding = {
        left = 10,
        right = 10,
        top = 10,
        bottom = 10,
    },
    keys = {}
}

return config
