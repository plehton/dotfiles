-- Commands for vim.pack utilities (lua/pjl/packutils.lua)

local packutils = require('pjl.packutils')

-- List inactive (orphaned) plugins
vim.api.nvim_create_user_command('PackInactive', function()
  local names = packutils.list_inactive()
  if #names == 0 then
    vim.notify('[PackInactive] No inactive plugins', vim.log.levels.INFO)
    return
  end
  vim.notify('Inactive plugins:\n' .. table.concat(names, '\n'), vim.log.levels.INFO)
end, { desc = 'List inactive (orphaned) vim.pack plugins' })

-- Prune all inactive plugins (with confirmation)
vim.api.nvim_create_user_command('PackPrune', function()
  packutils.prune()
end, { desc = 'Delete inactive (orphaned) vim.pack plugins from disk' })
