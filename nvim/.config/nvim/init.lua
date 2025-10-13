vim.g.mapleader = " "

require 'config.options'
require 'config.mappings'
require 'config.lsp'
require 'config.autocommands'

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
    spec = {
        -- import plugins which need configuration etc.
        { import = "plugins" },
        -- and add small plugins which require no configuration
        { "/rose-pine/neovim", name = "rose-pine" },
        "christoomey/vim-tmux-navigator",
        "justinmk/vim-dirvish",
        "romainl/vim-cool",
        "tpope/vim-repeat",
        "tpope/vim-surround",
        "tpope/vim-unimpaired",
        "tpope/vim-eunuch"
    }
})

vim.cmd.colorscheme("rose-pine")
