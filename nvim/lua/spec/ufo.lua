return {
    'kevinhwang91/nvim-ufo',
    lazy = false,
    dependencies = 'kevinhwang91/promise-async',
    keys = {
        { 'zr', function() require('ufo').openAllFolds() end },
        { 'zm', function() require('ufo').closeAllFolds() end },
        { 'z1', function() require('ufo').closeFoldsWith(1) end },
        { 'z2', function() require('ufo').closeFoldsWith(2) end },
        { 'z3', function() require('ufo').closeFoldsWith(3) end },
        { 'z4', function() require('ufo').closeFoldsWith(4) end },
    },
    opts = {
            provider_selector = function(bufnr, filetype, buftype)
            local treesitter_folding = {
                'markdown',
                'toml',
                'json',
                'vim',
                'vimdoc',
            }
                if vim.tbl_contains(treesitter_folding, filetype) then
                    return { 'treesitter', 'indent' }
                end
                return { "lsp", "indent" }
            end

    },

}
