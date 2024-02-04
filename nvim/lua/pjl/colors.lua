local bit = require('bit')
local math = require('math')

local colors = {}

-- Change vim color code in hex to an rgb color
colors.to_rgb = function(hexcolor)

    -- remove leading # and change hex to int
    local color_code = hexcolor:sub(2)
    local color_num = tonumber(color_code,16)

    -- extract r,b,g values from color number
    local red   = bit.rshift(color_num, 16)
    local green = bit.band(color_num, 0x0000FF)
    local blue  = bit.band(bit.rshift(color_num, 8), 0x00FF)

    return {red = red, blue = blue, green = green}

end


-- Get brightness of a vim color as value between 0 and 1
colors.get_brightness = function(hexcolor)

    local rgb = colors.to_rgb(hexcolor)

    return (rgb.red   / 255.0) * 0.30
         + (rgb.green / 255.0) * 0.59
         + (rgb.blue  / 255.0) * 0.11

end


-- Changes the brightness of a color
--
colors.set_brightness = function(hexcolor, amount)

    local max = function(value)
        return math.max(math.min(value, 255), 0)
    end

    local rgb = colors.to_rgb(hexcolor)

    local red = max(rgb.red + amount)
    local green = max(rgb.green + amount)
    local blue = max(rgb.blue + amount)

    local changed = bit.bor(green, bit.lshift(blue, 8), bit.lshift(red, 16))

    return string.format("#%06x", changed)

end


-- Convert a table of highlights to a highlight definition string
--
colors.to_highlight_color = function(color)

  local style = color.style and "gui=" .. color.style or "gui=NONE"
  local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
  local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
  local sp = color.sp and "guisp=" .. color.sp or ""

  return style .. " " .. fg .. " " .. bg .. " " .. sp

end


-- Get a table of colors from a highlight group
--
colors.get_highlight_colors = function(highlight)

  local result = {}
  local mapping = {
        background = "bg",
        foreground = "fg"
    }

  local list = vim.api.nvim_get_hl(0, { name = highlight })

  for group, color in pairs(list) do
    local name = mapping[group] ~= nil and mapping[group] or group
    result[name] = type(color) == "boolean" and color or string.format("#%06x", color)
  end

  return result

end


-- Change brightness of Normal background
--
-- Check if we're changing light or dark background and and if bg is light,
-- lighten a bit more than what's given to make the difference more distinct.
--
colors.dim_bg = function(amount)

    local old_bg = colors.get_highlight_colors("Normal").bg

    local brightness = colors.get_brightness(old_bg)
    if brightness > 0.5 then amount = -amount-1 end

    local new_bg = colors.set_brightness(old_bg, amount)

    return colors.to_highlight_color({ bg = new_bg })
end


-- Make buffer content pop out from background and lighten/darken background
-- color after textwidth and end of buffer.
colors.Customize = function(amount)

    local bg = colors.dim_bg(amount)
    local split_color = colors.get_highlight_colors("StatusLineNc").fg

    local highlights = {
        "highlight clear ColorColumn",
        "highlight ColorColumn " .. bg,
        "highlight link EndOfBuffer ColorColumn",
        "highlight clear WinSeparator",
        "highlight WinSeparator guifg=" .. split_color
        }

    -- Update Diagnostic Signs to have 
    local signs = { "Error", "Warn", "Hint", "Info" }

    local sign_bg = colors.get_highlight_colors("SignColumn").bg

    if sign_bg ~= nil then
        for _, sign in ipairs(signs) do
            table.insert(highlights, "highlight Diagnostic" .. sign .. " guibg=" .. sign_bg)
        end
    end

    return vim.cmd(table.concat(highlights, "\n"))

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
