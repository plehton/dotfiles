local statusline = {}

-- default colors
vim.cmd [[ hi User3 cterm=bold ctermfg=231 ctermbg=160 gui=bold guifg=White guibg=Red ]]
local modified_lhs_color = 'User3'
local default_lhs_color = 'Statusline'
local status_highlight = default_lhs_color

statusline.changed = ' '

statusline.check_modified = function()
    local modified = vim.bo.modified

    if modified and status_highlight ~= modified_lhs_color then
       status_highlight = modified_lhs_color
       statusline.changed = ' '
    else
       status_highlight = default_lhs_color
       statusline.changed = ' '
    end
    statusline.update_highlight()
end


statusline.update_highlight = function()
    vim.cmd('hi link User1 ' .. status_highlight)
    vim.cmd('hi User2 cterm=bold,inverse gui=bold,inverse')
end


statusline.lhs = function()
    -- line numbers + foldcolumn
    local numwidth = math.max(string.len(vim.api.nvim_buf_line_count(0)), vim.wo.numberwidth)
    local padding = numwidth + vim.wo.foldcolumn + 1
    return string.rep(' ', padding)
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
        .. '%* '
        .. '%f'
        .. '%{luaeval("require\'pjl.statusline\'.changed")}'
        .. '%='
        .. '%2*'
        .. '%{luaeval("require\'pjl.statusline\'.rhs()")}'
    )

end

return statusline
