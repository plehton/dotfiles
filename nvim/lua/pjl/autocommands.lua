local autocommands = {}


autocommands.colorcolumn = function()
    vim.cmd("let &l:colorcolumn ='+' . join(range(0,200),',+')")
end

return autocommands
