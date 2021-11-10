local autocommands = {}


autocommands.colorcolumn = function()
    vim.cmd("let &l:colorcolumn ='+' . join(range(1,200),',+')")
end

return autocommands
