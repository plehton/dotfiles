local colors = {}

colors.change_brightness = function(color, amount)

    local bit = require('bit')
    local math = require('math')

    local color_code = color:sub(2)
    local color_num = tonumber(color_code,16)
   
    local red = math.max(math.min(bit.rshift(color_num, 16) + amount, 255),0)
    local blue = math.max(math.min(bit.band(bit.rshift(color_num, 8), 0x00FF) + amount, 255), 0)
    local green = math.max(math.min(bit.band(color_num, 0x0000FF) + amount, 255), 0)

    local changed = bit.bor(green, bit.lshift(blue, 8), bit.lshift(red, 16))

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
