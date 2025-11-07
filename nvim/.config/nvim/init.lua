vim.g.mapleader = " "

require 'config.options'
require 'config.mappings'
require 'config.lsp'
require 'config.autocommands'

-- lazy.nvim and plugins {{{
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
require("lazy").setup({
    change_detection = { enabled = false },
    spec = {
        -- import plugins which need configuration etc.
        { import = "plugins" },
        -- and add small plugins which require no configuration
        "christoomey/vim-tmux-navigator",
        "justinmk/vim-dirvish",
        "romainl/vim-cool",
        "tpope/vim-eunuch",
        "tpope/vim-repeat",
        "tpope/vim-surround",
        "tpope/vim-unimpaired",
    }
})
-- }}}

vim.cmd.colorscheme("rose-pine")
