local autocmd = function(name, pattern, cmd)
    vim.cmd('autocmd ' .. name .. ' ' .. pattern .. ' ' .. cmd)
end

return autocmd
