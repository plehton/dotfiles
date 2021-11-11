local bit = require('bit')
local math = require('math')

local colors = {}

colors.to_rgb = function(hexcolor)

    color_code = hexcolor:sub(2)
    color_num = tonumber(color_code,16)
   
    red = bit.rshift(color_num, 16)
    blue = bit.band(bit.rshift(color_num, 8), 0x00FF)
    green = bit.band(color_num, 0x0000FF)

    return {red = red, blue = blue, green = green}

end

colors.get_brightness = function(rgb)

    return (rgb.red / 255.0) * 0.3 + (rgb.green / 255.0) * 0.59 + (rgb.blue / 255.0) * 0.11

end


colors.change_brightness = function(hexcolor, amount)

    rgb = colors.to_rgb(hexcolor)
   
    -- check the brightness of the background and
    -- lighten when dark and darken when light
    brightness = colors.get_brightness(rgb)

    if brightness > 0.5 then amount = -amount end
    -- amount = colors.get_brightness(rgb) < 0.5 and amount or -amount

    red = math.max(math.min(rgb.red + amount, 255),0)
    blue = math.max(math.min(rgb.blue + amount, 255), 0)
    green = math.max(math.min(rgb.green+ amount, 255), 0)

    changed = bit.bor(green, bit.lshift(blue, 8), bit.lshift(red, 16))

    return string.format("#%06x", changed)

end

colors.to_highlight_color = function(color)
  local style = color.style and "gui=" .. color.style or "gui=NONE"
  local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
  local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
  local sp = color.sp and "guisp=" .. color.sp or ""
  return style .. " " .. fg .. " " .. bg .. " " .. sp
end

colors.from_highlight = function(highlight)
  local result = {}
  local list = vim.api.nvim_get_hl_by_name(highlight, true)
  for k, v in pairs(list) do
    local name = k == "background" and "bg" or "fg"
    result[name] = string.format("#%06x", v)
  end
  return result
end

colors.get_dimmed_background = function(amount) 
    local normal = colors.from_highlight("Normal")
    local dimmed = colors.change_brightness(normal.bg, amount) 
    return colors.to_highlight_color({ bg = dimmed })
end

return colors
