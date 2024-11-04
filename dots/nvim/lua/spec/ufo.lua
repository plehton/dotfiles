return {
    'kevinhwang91/nvim-ufo',
    lazy = false,
    dependencies = 'kevinhwang91/promise-async',
    keys = {
        "Tab",
        { 'zR', function() require('ufo').openAllFolds() end },
        { 'zM', function() require('ufo').closeAllFolds() end },
        { 'z1', function() require('ufo').closeFoldsWith(1) end },
        { 'z2', function() require('ufo').closeFoldsWith(2) end },
        { 'z3', function() require('ufo').closeFoldsWith(3) end },
        { 'z4', function() require('ufo').closeFoldsWith(4) end },
        { ']z', function() require('ufo').goNextClosedFold() end },
        { '[z', function() require('ufo').goPreviousClosedFold() end },
    },
    opts = {
        ---@diagnostic disable-next-line: unused-local
        provider_selector = function(bufnr, filetype, buftype)
            local lsp_folding = {
                'json',
                'lua',
                'python',
                'scala',
                'terraform',
            }
            if vim.tbl_contains(lsp_folding, filetype) then
                return { "lsp", "indent" }
            end
            return { 'treesitter', 'indent' }
        end
    },

}
