local augroup = function (name, callback)
  vim.cmd('augroup ' .. name)
  vim.cmd('autocmd!')
  callback()
  vim.cmd('augroup END')
end

return augroup
