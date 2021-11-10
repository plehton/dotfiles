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


colors.change_brightness = function(color, amount)

    rgb = colors.to_rgb(color)
   
    -- check the brightness of the background and
    -- lighten when dark and darken when light
    if colors.get_brightness(rgb) > 0.5 then amount = -amount end

    red = math.max(math.min(rgb.red + amount, 255),0)
    blue = math.max(math.min(rgb.blue + amount, 255), 0)
    green = math.max(math.min(rgb.green+ amount, 255), 0)

    changed = bit.bor(green, bit.lshift(blue, 8), bit.lshift(red, 16))

    return string.format("#%06x", changed)

end

colors.highlight = function(group, color)
  local style = color.style and "gui=" .. color.style or "gui=NONE"
  local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
  local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
  local sp = color.sp and "guisp=" .. color.sp or ""
  local hl = "highlight " .. group .. " " .. style .. " " .. fg .. " " .. bg .. " " .. sp
  return hl
end

colors.tohl= function(color)
  local style = color.style and "gui=" .. color.style or "gui=NONE"
  local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
  local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
  local sp = color.sp and "guisp=" .. color.sp or ""
  return style .. " " .. fg .. " " .. bg .. " " .. sp
end

colors.fromhl = function(hl)
  local result = {}
  local list = vim.api.nvim_get_hl_by_name(hl, true)
  for k, v in pairs(list) do
    local name = k == "background" and "bg" or "fg"
    result[name] = string.format("#%06x", v)
  end
  return result
end

return colors
