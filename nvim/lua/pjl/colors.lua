local bit = require('bit')
local math = require('math')

local colors = {}

colors.to_rgb = function(color)

    -- extract r,b,g values from color number
    local red   = bit.rshift(color, 16)
    local green = bit.band(color, 0x0000FF)
    local blue  = bit.band(bit.rshift(color, 8), 0x00FF)

    return {red = red, blue = blue, green = green}

end

-- Change vim color code in hex to an rgb color
colors.hex_to_rgb = function(hexcolor)

    -- remove leading # and change hex to int
    local hex = hexcolor:sub(2)
    local num = tonumber(hex,16)

    colors.to_rgb(num)
end


-- Get brightness of a vim color as value between 0 and 1
colors.get_brightness = function(color)

    local rgb = colors.to_rgb(color)

    return (rgb.red   / 255.0) * 0.30
         + (rgb.green / 255.0) * 0.59
         + (rgb.blue  / 255.0) * 0.11

end


-- Changes the brightness of a color
--
colors.set_brightness = function(color, amount)

    local max = function(value)
        return math.max(math.min(value, 255), 0)
    end

    local rgb = colors.to_rgb(color)

    local red = max(rgb.red + amount)
    local green = max(rgb.green + amount)
    local blue = max(rgb.blue + amount)

    local faded = bit.bor(green, bit.lshift(blue, 8), bit.lshift(red, 16))

    return faded
    -- return string.format("#%06x", changed)

end


-- Change brightness of Normal background
--
-- Check if we're changing light or dark background and and if bg is light,
-- lighten a bit more than what's given to make the difference more distinct.
--
colors.fade = function(color, amount)

    local brightness = colors.get_brightness(color)
    if brightness > 0.5 then amount = -amount - 1 end
    return colors.set_brightness(color, amount)

end


-- Make buffer content pop out from background and lighten/darken background
-- color after textwidth and end of buffer.
colors.Customize = function(amount)

    local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
    local faded_bg = colors.fade(bg, amount)

    local split_color = vim.api.nvim_get_hl(0, { name = "StatusLineNc" }).fg

    vim.api.nvim_set_hl(0,"ColorColumn", { background = faded_bg })
    vim.api.nvim_set_hl(0,"EndOfBuffer", { background = faded_bg })
    vim.api.nvim_set_hl(0,"WinSeparator", { foreground = split_color })

    local signs = { "Error", "Warn", "Hint", "Info" }
    local hl_signs = vim.api.nvim_get_hl(0, { name = "SignColumn"})
    hl_signs.bg = faded_bg
    for _, sign in ipairs(signs) do
            vim.api.nvim_set_hl(0, "Diagnostic" .. sign, { background = faded_bg })
    end

end


colors.colorscheme = function()

    local theme
    local theme_file = vim.fn.expand('~/.theme')

    if vim.fn.filereadable(theme_file) then
        _, theme = next(vim.fn.readfile(theme_file))
    else
        print("pjl.colorscheme: ~/.theme is not found! Keeping current colorscheme")
        return
    end

    if vim.g.colors_name ~= nil and vim.g.colors_name == theme then
        return
    end

    vim.cmd.colorscheme(theme)

end

return colors
