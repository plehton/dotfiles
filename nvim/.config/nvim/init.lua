vim.g.mapleader = " "

require 'config.options'
require 'config.mappings'
require 'config.lsp'
require 'config.autocommands'

vim.pack.add({
    -- Core
    "https://github.com/tpope/vim-eunuch",
    "https://github.com/tpope/vim-repeat",
    "https://github.com/tpope/vim-surround",
    "https://github.com/tpope/vim-unimpaired",
    "https://github.com/tpope/vim-fugitive",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    -- "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    -- File manager
    "https://github.com/justinmk/vim-dirvish",
    -- UI
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    -- LSP
    "https://github.com/scalameta/nvim-metals",
    -- "https://github.com/artemave/workspace-diagnostics.nvim",
    -- AI
    "https://github.com/zbirenbaum/copilot.lua",
    "https://github.com/CopilotC-Nvim/CopilotChat.nvim",
    -- Colorschemes
    "https://github.com/catppuccin/nvim",
    "https://github.com/p00f/alabaster.nvim",
    "https://github.com/marekh19/meowsoot.nvim",
    "https://github.com/rose-pine/neovim",
})

-- Synchronous build for telescope-fzf-native (PackChanged doesn't fire during initial add)
local fzf_path = vim.fn.stdpath('data') .. '/site/pack/core/opt/telescope-fzf-native.nvim'
if vim.fn.isdirectory(fzf_path) == 1 and vim.fn.filereadable(fzf_path .. '/build/libfzf.so') == 0 then
    vim.system({ 'make' }, { cwd = fzf_path }):wait()
end

-- Build hook for future updates via PackChanged
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == 'telescope-fzf-native' and kind == 'update' then
            vim.system({ 'make' }, { cwd = ev.data.path }):wait()
        end
    end,
})

vim.cmd.colorscheme("catppuccin")
