local statusline = {}

-- set user colors
-- user3 = lhs, when buffer is modified
-- user2 = rhs
vim.cmd [[ hi User3 cterm=bold ctermfg=231 ctermbg=160 gui=bold guifg=White guibg=Red ]]
vim.cmd [[ hi User2 cterm=bold,inverse gui=bold,inverse ]]

local modified_lhs_color = 'User3'
local default_lhs_color = 'Statusline'
local status_highlight = default_lhs_color

statusline.changed = ' '
statusline.lhs_flag = ' '

statusline.update_highlight = function()
    vim.cmd('hi link User1 ' .. status_highlight)
end

statusline.check_modified = function()
    local modified = vim.bo.modified

    if modified and status_highlight ~= modified_lhs_color then
       status_highlight = modified_lhs_color
       statusline.changed = ' '
       statusline.lhs_flag =  ''
    else
       status_highlight = default_lhs_color
       statusline.changed = ' '
       statusline.lhs_flag =  ' '
    end
    statusline.update_highlight()
end

statusline.file_or_lsp_status = function()
    -- Neovim keeps the messages send from the language server in a buffer and
    -- get_progress_messages polls the messages
    local messages = vim.lsp.util.get_progress_messages()
    local mode = vim.api.nvim_get_mode().mode
    local metals_status = vim.g.metals_status

    -- If neovim isn't in normal mode, or if there are no messages from the
    -- language server and no metals status info display the file name
    if mode ~= 'n' or (vim.tbl_isempty(messages) and (metals_status == '' or metals_status == nil)) then
        return vim.fn.expand('%:f')
    end

    -- if metals status exists, use that, otherwise
    -- proceed into checking lsp messages
    if metals_status ~= nil or metals_status ~= '' then
        return metals_status
    end

    local percentage
    local result = {}
    -- Messages can have a `title`, `message` and `percentage` property
    -- The logic here renders all messages into a stringle string
    for _, msg in pairs(messages) do
        if msg.message then
            table.insert(result, msg.title .. ': ' .. msg.message)
        else
            table.insert(result, msg.title)
        end
        if msg.percentage then
            percentage = math.max(percentage or 0, msg.percentage)
        end
    end

    if percentage then
        return string.format('%03d: %s', percentage, table.concat(result, ', '))
    else
        return table.concat(result, ', ')
    end
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
    -- width of a line without $ > number of chars
    local width =  vim.fn.virtcol('$') - 1

    rhs = rhs .. 'ℓ '
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

    parts = {
        [[%1*]],
        [[%{luaeval("require'pjl.statusline'.lhs()")}]],
        [[%*]],
        -- [[ %f%r]],
        [[%{luaeval("require'pjl.statusline'.file_or_lsp_status()")}]],
        [[%{luaeval("require'pjl.statusline'.changed")}]],
        [[%=]],
        [[%2*]],
        [[ %{luaeval("require'pjl.statusline'.rhs()")}]],
    }
    return table.concat(parts,'')

end

return statusline
