-- Set options {{{

-- Visuals {{{
vim.o.number         = true
vim.o.relativenumber = true
vim.o.showmatch      = true
vim.o.splitbelow     = true
vim.o.splitright     = true
vim.o.updatetime     = 1000
vim.o.winborder      = "rounded"
--}}}

-- Indentation {{{
vim.o.shiftwidth     = 4
vim.o.tabstop        = 4
vim.o.softtabstop    = 4
vim.o.smartindent    = true
vim.o.expandtab      = true
-- }}}

-- Searching {{{
vim.o.hlsearch       = true
vim.o.incsearch      = true
vim.o.ignorecase     = true
vim.o.smartcase      = true
vim.o.grepprg        = 'rg --vimgrep --no-heading'
vim.o.grepformat     = '%f:%l:%c:%m'
vim.o.gdefault       = true
-- }}}

-- Use undofile, no swap, no backups {{{
vim.o.undofile       = true
vim.o.swapfile       = false
vim.o.backup         = false
vim.o.writebackup    = false
-- }}}

-- }}}
