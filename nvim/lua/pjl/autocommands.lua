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

    local cc_color = colors.get_dimmed_background(7)
    local vs_color = colors.from_highlight("StatusLineNc").fg

    local commands = { 
    "highlight clear ColorColumn",
    "highlight ColorColumn " .. cc_color,
    "highlight link EndOfBuffer ColorColumn",
    -- show vertical bar between buffers
    "highlight clear VertSplit",
    "highlight VertSplit guifg=" .. vs_color
    }
    return vim.cmd(table.concat(commands,"\n")) 

end

return autocommands
