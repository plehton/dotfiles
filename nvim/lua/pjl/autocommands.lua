local colors = require('pjl.colors')
local autocommands = {}

--This function is taken from https://github.com/norcalli/nvim_utils
autocommands.create_augroups = function(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command('augroup '..group_name)
        api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            api.nvim_command(command)
        end
        api.nvim_command('augroup END')
    end
end


-- Lighten default background a little for columns after wrapmargin and rows
-- after EndOfBuffer
autocommands.colors = function()

    -- Make buffer content pop out from background and
    -- lighten/darken background color after textwidth and end of buffer
    local bg = colors.change_bg_brightness(5)
    local split = colors.get_highlight_colors("StatusLineNc").fg

    local highlights = { 
        "highlight clear ColorColumn",
        "highlight ColorColumn " .. bg,
        "highlight link EndOfBuffer ColorColumn",
        "highlight clear VertSplit",
        "highlight VertSplit guifg=" .. split
        }

    -- Diagnostic Signs have same background as SignColumn
    local signs = { "Error", "Warn", "Hint", "Info" }
    local sign_bg = colors.get_highlight_colors("SignColumn").bg
    for _, sign in ipairs(signs) do
        table.insert(highlights, "highlight Diagnostic" .. sign .. " guibg=" .. sign_bg)
    end

    return vim.cmd(table.concat(highlights, "\n"))

end

return autocommands
