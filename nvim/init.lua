--
-- Set options
--

vim.g.mapleader                  = " "

-- NvimTree needs netrw disabled
vim.g.loaded_netrw               = 1
vim.g.loaded_netrwPlugin         = 1

vim.o.termguicolors              = true

vim.o.clipboard                  = 'unnamed'
vim.o.history                    = 1000

vim.o.settermguicolors           = true
vim.o.lazyredraw                 = true
vim.o.swapfile                   = false
vim.o.undofile                   = true
vim.o.backup                     = false
vim.o.writebackup                = false

vim.o.shortmess                  = vim.o.shortmess .. 'c'
vim.o.completeopt                = "menuone,noselect"
vim.o.wildmode                   = "longest:full,full"
vim.o.diffopt                    = vim.o.diffopt .. ',vertical'
vim.o.showmatch                  = true
vim.o.noincsearch                = true
vim.o.ignorecase                 = true
vim.o.incsearch                  = false
vim.o.ignorecase                 = true
vim.o.smartcase                  = true
vim.o.gdefault                   = true -- search replaces all matches instead of one

vim.o.splitright                 = true
vim.o.splitbelow                 = true
vim.o.fillchars                  = vim.o.fillchars .. 'vert:│'

vim.o.expandtab                  = true
vim.o.shiftwidth                 = 4
vim.o.softtabstop                = 4

vim.o.number                     = true
vim.o.relativenumber             = true
vim.o.textwidth                  = 80
vim.o.scrolloff                  = 3
vim.o.sidescrolloff              = 10
vim.o.sidescroll                 = 5
vim.o.modelines                  = 0
vim.o.cursorline                 = true
vim.o.cursorlineopt              = 'number'
vim.o.listchars                  = 'tab:⇥ ,trail:·'
vim.o.list                       = true

vim.o.foldcolumn                = '0'
vim.o.foldmethod                = "expr"
vim.o.foldexpr                  = "nvim_treesitter#foldexpr()"
vim.o.foldenable                = false

-- set the background color of all columns right of textwidth to indicate 
-- long lines
local function set_colorcolumn(max_column)
   local cc = {}
   for i = 1,max_column do
      table.insert(cc, '+' .. i)
   end
   return table.concat(cc,',')
end
vim.o.colorcolumn = set_colorcolumn(258)

-- when wrap is on, break lines on linebreak characters,
-- show symbol at the beginning of the line and
-- indent wrapped lines using shiftwidth amount of chars
-- 
vim.o.nowrap=true
vim.o.breakindent=true
vim.o.linebreak=true
vim.o.showbreak='↪ '
vim.o.breakindentopt = 'sbr,shift:' .. (vim.o.shiftwidth-2)

-- user rg for grepping
vim.o.grepprg='rg --vimgrep --no-heading'
vim.o.grepformat='%f:%l:%c:%m'

vim.o.statusline="%!v:lua.require'pjl.statusline'.set()"

--
-- Load plugins
--

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("spec")
