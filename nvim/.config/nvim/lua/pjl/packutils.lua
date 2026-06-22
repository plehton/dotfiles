--- Prune inactive (orphaned) plugins managed by vim.pack.
---
--- Plugins with `active = false` are those present in nvim-pack-lock.json
--- but no longer declared in any `vim.pack.add()` call. This function
--- lists them and optionally deletes them from disk.

local M = {}

--- @param opts? {force: boolean}
--- @return string[] names of inactive (orphaned) plugins
function M.list_inactive(opts)
  opts = opts or {}
  local all = vim.pack.get(nil, { info = false })
  local inactive = {}
  for _, p in ipairs(all) do
    if not p.active then
      table.insert(inactive, p.spec.name)
    end
  end
  return inactive
end

--- Delete all inactive (orphaned) plugins from disk.
--- @param opts? {force: boolean}
function M.prune(opts)
  opts = vim.tbl_extend('force', { force = false }, opts or {})
  local inactive = M.list_inactive()
  if #inactive == 0 then
    vim.notify('[packutils] No inactive plugins to prune', vim.log.levels.INFO)
    return
  end

  -- Show what will be deleted
  local msg = 'Inactive plugins:\n' .. table.concat(inactive, '\n')
  if not opts.force then
    -- Confirm with the user (opt-in per plugin)
    local confirm = vim.fn.confirm(msg .. '\n\nDelete all?', "&Yes\n&No", 2)
    if confirm ~= 1 then
      vim.notify('[packutils] Prune cancelled', vim.log.levels.INFO)
      return
    end
  else
    vim.notify(msg, vim.log.levels.INFO)
  end

  vim.pack.del(inactive, { force = true })
  vim.notify(
    string.format('[packutils] Pruned %d inactive plugin(s)', #inactive),
    vim.log.levels.INFO
  )
end

return M
