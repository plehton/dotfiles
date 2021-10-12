local statusline = {}

-- default colors
local modified_lhs_color = 'DiffDelete'
local default_lhs_color = 'DiffChange'
local status_highlight = default_lhs_color


statusline.check_modified = function()
    local modified = vim.bo.modified
    if modified and status_highlight ~= modified_lhs_color then
       status_highlight = modified_lhs_color 
    else
       status_highlight = default_lhs_color
    end
    statusline.update_highlight()
end


statusline.update_highlight = function()
    vim.cmd('hi link User1 ' .. status_highlight)
    vim.cmd('hi User2 cterm=bold,inverse gui=bold,inverse')
end


statusline.lhs = function()
    if vim.bo.modified then
        return ' ✗ '
    else 
        return '   '
    end
end


statusline.rhs = function()

    local rhs = ''

    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    local height = vim.api.nvim_buf_line_count(0)
    local column =  vim.fn.virtcol('.')
    local width =  vim.fn.virtcol('$')

    rhs = rhs .. ' ℓ '
    rhs = rhs .. line
    rhs = rhs .. '/'
    rhs = rhs .. height
    rhs = rhs .. ' 𝚌 '
    rhs = rhs .. column
    rhs = rhs .. '/'
    rhs = rhs .. width 
    rhs = rhs .. ' '

    return rhs
end


statusline.set = function()

    vim.api.nvim_set_option('statusline', ''
        .. '%1*'
        .. '%{luaeval("require\'pjl.statusline\'.lhs()")}'
        .. '%*'
        .. '%f'
        .. '%='
        .. '%2*'
        .. '%{luaeval("require\'pjl.statusline\'.rhs()")}'
    )

end

return statusline
