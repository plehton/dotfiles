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

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require 'nvim-treesitter'.install(TYPES)
            local augroup = vim.api.nvim_create_augroup("pjl-treesitter", { clear = true })
            vim.api.nvim_create_autocmd('FileType', {
                group = augroup,
                pattern = TYPES,
                callback = function()
                    vim.treesitter.start()
                    vim.wo.foldmethod = 'expr'
                    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end
    }
}
