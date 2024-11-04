local Color = require('pjl.Color')

local colors = {}

colors.get = function(hl_name)
    return vim.api.nvim_get_hl(0, { name = hl_name })
end

colors.set = function(hl_name, values)
    return vim.api.nvim_set_hl(0, hl_name, values)
end

colors.fg = function(hl_name)
    return colors.get(hl_name).fg
end

colors.bg = function(hl_name)
    return colors.get(hl_name).bg
end

colors.lighten = function(color, amount)
    local c = Color(color)
    local l = (1 + amount) * c.L
    l = math.min(l, 1)
    local c1 = c:lighten_to(l)
    return c1:to_rgb_string()
end

colors.darken = function(color, amount)
    local c = Color(color)
    local l = (1 - amount) * c.L
    l = math.max(l, 0)
    local c1 = c:lighten_to(l)
    return c1:to_rgb_string()
end

colors.italicize = function(hl_name)
    local hl = colors.get(hl_name)
    hl.italic = true
    return hl
end

colors.embolden = function(hl_name)
    local hl = colors.get(hl_name)
    hl.bold = true
    return hl
end

colors.invert = function(hl_name)
    local hl = colors.get(hl_name)
    hl.reverse = true
    return hl
end

colors.link = function(hl_from, hl_to)
    vim.cmd("hi link " .. hl_from .. ' ' .. hl_to)
end

-- change lightness of given color a little bit lighter for dark colors
-- and darker for light colors. Amount of fade depends of the luminance of given
-- color: darker colors change more than light colors.
colors.fade = function(color)
    local c = Color(color)
    local change_dark = 0.2
    local change_light = 0.015
    local amount = change_dark - c.L * (change_dark - change_light)
    -- vim.notify("Fading " .. color ..": luminance = " .. c.L .. ", amount = " .. amount, vim.log.levels.DEBUG)
    if c.L > 0.5 then
        return colors.darken(color, amount)
    else
        return colors.lighten(color, amount)
    end
end

-- Darken/lighten gutter and visible area outside of the text
colors.colorize = function()

    local bg = colors.bg("Normal")
    bg = colors.fade(bg)

    colors.set("ColorColumn", { bg = bg })
    colors.set("EndOfBuffer", { bg = bg })

    local signs = { "Error", "Warn", "Hint", "Info" }
    for _, sign in ipairs(signs) do
        colors.set("Diagnostic" .. sign, { bg = bg })
    end

    -- tone down the split separators
    local split_color = colors.fg("StatusLineNc")
    colors.set("WinSeparator", { fg = split_color })
end

colors.sync_colorscheme = function(force)

    local file = io.open(vim.fn.expand("$HOME/.colorscheme"), "r")
    assert(file, "Can't open ~/.colorscheme for reading!")

    local colorscheme = file:read("*l")
    assert(colorscheme, "Can't read colorscheme from ~/.colorscheme")

    file:close()

    if not force and colorscheme == vim.g.colors_name then
        return
    end

    local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)

    if not status_ok then
        vim.notify("Colorscheme " .. colorscheme .. " not found!")
        return
    end

end

return colors
