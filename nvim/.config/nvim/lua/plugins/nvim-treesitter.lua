return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = "TSUpdate",
        config = function()
            local types = { 'bash', 'python', 'vim', 'help', 'lua', 'scala', 'terraform' }
            require 'nvim-treesitter'.install(types)
            local augroup = vim.api.nvim_create_augroup("pjl-treesitter", { clear = true })
            vim.api.nvim_create_autocmd('FileType', {
                group = augroup,
                pattern = types,
                callback = function()
                    vim.treesitter.start()
                    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end
    }
}
