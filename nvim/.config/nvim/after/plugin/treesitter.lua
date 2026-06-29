local TYPES = {
    'bash',
    'html',
    'lua',
    'markdown',
    'python',
    'scala',
    'terraform',
    'vim',
    'zsh',
}

-- nvim-treesitter has its query files under runtime/queries/, but vim.pack
-- only adds the plugin root to 'runtimepath', not the runtime/ subdirectory.
-- Add runtime/ explicitly so queries (highlights, folds, etc.) are findable.
local ts_root = vim.fn.stdpath('data') .. '/site/pack/core/opt/nvim-treesitter'
vim.opt.rtp:append(ts_root .. '/runtime')

require 'nvim-treesitter'.install(TYPES)

local augroup = vim.api.nvim_create_augroup("pjl-treesitter", { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    pattern = TYPES,
    callback = function()
        vim.treesitter.start()
        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.bo.indentexpr = "v:lua.vim.treesitter.indentexpr()"
    end,
})

