local colors = require('pjl.colors')

local statusline = {}

local default_lhs_color  = 'PjlStatusDefault'
local modified_lhs_color = 'PjlStatusModified'
local lhs_color = default_lhs_color

statusline.branch = ''

statusline.check_modified = function()
    local modified = vim.bo.modified
    if modified and lhs_color ~= modified_lhs_color then
        lhs_color = modified_lhs_color
        statusline.update_highlights()
    elseif not modified then
        lhs_color = default_lhs_color
        statusline.changed = '  '
        statusline.update_highlights()
    end
end

statusline.branch = function()
    local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
    if branch == '' or branch == nil then return '' end
    return string.format(" %s", branch)
end

statusline.filename = function()
    local opts = {
        vim.bo.filetype,
        vim.bo.fileformat == 'unix' and '' or vim.bo.fileformat,
        vim.bo.fileencoding == 'utf-8' and '' or vim.bo.fileencoding,
    }

    local flags = ''
    for i, opt in ipairs(opts) do
        if i > 1 and opt ~= '' then
            flags = flags .. ','
        end
        flags = flags .. opt
    end

    if flags ~= '' then flags = ' [' .. flags .. ']' end

    return vim.fn.expand('%:F') .. flags
end


statusline.padding = function()
    local winid = vim.api.nvim_get_current_win()
    return vim.fn.getwininfo(winid)[1].textoff + 1
end

statusline.update_highlights = function()

    colors.set("PjlStatusDefault", { fg = "White", bg = "LightGreen"})
    colors.set("PjlStatusModified", { fg = "White", bg = "Orange"})

    -- Modified indicator
    colors.link('User1 ', lhs_color)

    -- powerline arrow inverts User1
    colors.set("User2", { fg = colors.bg(lhs_color) })

    -- branch name
    colors.set("User3", colors.invert("StatusLine"))

    --line/col
    local u4 = colors.lighten(colors.bg("Normal"), 0.5)
    colors.set("User4", { fg = colors.fg("StatusLine"), bg = u4 })

end

statusline.inactive = function()

    vim.wo.statusline = ''
        .. string.rep(' ', statusline.padding() - 1)
        .. ' '
        .. ' '
        .. '%{v:lua.require("pjl.statusline").filename()}'

end

statusline.lhs = function()

    local padding = statusline.padding()

    if vim.bo.modified then
        return string.rep(' ', padding - 2) .. '✘ '
    else
        return string.rep(' ', padding)
    end

end

statusline.rhs = function()
    local rhs = ''

    local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
    local column = vim.fn.virtcol('.')
    local height = vim.api.nvim_buf_line_count(0)
    -- width of a line without $
    local width = vim.fn.virtcol('$') - 1

    rhs = rhs .. 'ℓ '
    rhs = rhs .. string.format(string.format("%%%ds", string.len(height)), line)
    rhs = rhs .. '/'
    rhs = rhs .. height
    rhs = rhs .. string.format("%-11s", ' 𝚌 ' .. column .. '/' .. width)

    return rhs
end

statusline.active = function()

    -- todo: add powerline arrow to rhs 

    vim.wo.statusline = ''
        .. '%1*'
        .. '%{v:lua.require("pjl.statusline").lhs()}'
        .. '%*'
        .. '%2*'
        .. ''
        .. '%*'
        .. ' '
        .. '%<'
        .. '%{v:lua.require("pjl.statusline").filename()}'
        .. '%='
        .. '%3*'
        .. ' '
        .. '%{v:lua.require("pjl.statusline").branch()}'
        .. ' '
        .. '%*'
        .. '%4*'
        .. ' '
        .. '%{v:lua.require("pjl.statusline").rhs()}'
        .. '%*'
end

return statusline
