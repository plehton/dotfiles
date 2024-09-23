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

colors.fade = function(color)
    local c = Color(color)
    -- we adjust the difference between faded and source color based
    -- on the luminance
    vim.notify('luminance ' .. c.L)
    local coeff = 1
    if c.L > 0.5 then
        return colors.darken(color, 0.015)
    else
        return colors.lighten(color, 0.1)
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

    if not force or colorscheme == vim.g.colors_name then
        return
    end

    vim.notify("Setting colorscheme to: " .. colorscheme)
    local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)

    if not status_ok then
        vim.notify("Colorscheme " .. colorscheme .. " not found!")
    end
end

return colors
