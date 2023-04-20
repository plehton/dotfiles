local statusline = {}

-- set user colors
vim.cmd [[ hi pjlStatusLhs gui=bold guifg=White guibg=#00d787]]
vim.cmd [[ hi pjlStatusLhsModified gui=bold guifg=White guibg=Red  ]]
vim.cmd [[ hi link pjlStatusRhs Cursor ]]
vim.cmd [[ hi pjlStatusBranch guifg=LightGrey guibg=BrightBlack ]]

local default_lhs_color = 'pjlStatusLhs'
local modified_lhs_color = 'pjlStatusLhsModified'
local status_highlight = default_lhs_color

statusline.changed = ' '
statusline.branch = ''


statusline.get_branch = function()

    local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")

    if branch == '' or branch == nil then return '' end

    -- local maxlen = 20
    -- if #branch > maxlen then
    --     branch = branch:sub(1,maxlen-3) .. '...'
    -- end

    return string.format("  %s ", branch)

end

statusline.lsp_status = function()

    -- Neovim keeps the messages send from the language server in a buffer and
    -- get_progress_messages polls the messages
    local messages = vim.lsp.util.get_progress_messages()
    local mode = vim.api.nvim_get_mode().mode
    local metals_status = vim.g.metals_status

    -- If neovim isn't in normal mode, or if there are no messages from the
    -- language server and no metals status info display the file name
    if mode ~= 'n' or (vim.tbl_isempty(messages) and (metals_status == '' or metals_status == nil)) then
        return nil
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


statusline.filename = function()

    -- if lsp has a status message, use that
    local lsp_status = statusline.lsp_status()
    if lsp_status then
        return lsp_status
    end

    -- otherwise, return filename with additional info
    -- filename.ext [filetype,format,encoding]
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


statusline.lhs = function()

    local content = statusline.changed .. ' '

    local numwidth = math.max(string.len(vim.api.nvim_buf_line_count(0)), vim.wo.numberwidth)
    local padding = numwidth + vim.wo.foldcolumn

    return string.rep(' ', padding) .. content
end


statusline.rhs = function()

    local rhs = ''

    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    local height = vim.api.nvim_buf_line_count(0)
    local column =  vim.fn.virtcol('.')
    -- width of a line without $
    local width =  vim.fn.virtcol('$') - 1

    rhs = rhs .. 'ℓ '
    rhs = rhs .. string.format(string.format("%%%ds", string.len(height)), line)
    rhs = rhs .. '/'
    rhs = rhs .. height
    rhs = rhs .. string.format("%-11s",  ' 𝚌 ' ..column .. '/' .. width)

    return rhs
end


statusline.set = function()

    -- todo: add powerline arrows 

    parts = {
        [[%1*]],
        [[%{luaeval("require'pjl.statusline'.lhs()")}]],
        [[%*]],
        [[%<]],
        [[ %{luaeval("require'pjl.statusline'.filename()")} ]],
        [[%=]],
        [[%#pjlStatusBranch#]],
        [[%{luaeval("require'pjl.statusline'.branch")}]],
        [[%#pjlStatusRhs#]],
        [[ %{luaeval("require'pjl.statusline'.rhs()")} ]],
    }
    return table.concat(parts,'')

end

statusline.check_modified = function()

    local modified = vim.bo.modified
    if modified and status_highlight ~= modified_lhs_color then
       status_highlight = modified_lhs_color
       statusline.changed = ''
    elseif not modified then
       status_highlight = default_lhs_color
       statusline.changed = ' '
    end

    statusline.branch = statusline.get_branch()
    statusline.update_highlights()

end

statusline.update_highlights = function()

    vim.cmd('hi link User1 ' .. status_highlight)

end

return statusline
