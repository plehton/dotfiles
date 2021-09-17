local lsp= require('lspconfig')

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

local cmp = require'cmp'
cmp.setup {
    mapping = {
        ['<Tab>'] = function(fallback)
            if vim.fn.pumvisible() == 1 then
              vim.api.nvim_feedkeys(t('<C-n>'), 'n', true)
            elseif check_back_space() then
              vim.api.nvim_feedkeys(t('<Tab>'), 'n', true)
            -- elseif vim.fn['vsnip#available']() == 1 then
              -- vim.api.nvim_feedkeys(t('<Plug>(vsnip-expand-or-jump)'), '', true)
            else
              fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
            elseif luasnip.jumpable(-1) then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
            else
                fallback()
            end
        end,
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true
          }),
      },
      sources = {
          { name = "buffer" },
          { name = "nvim_lsp" },
      }
  }

local on_attach = function(client, bufnr)

  local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function setopt(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  setopt('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  map('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map('n', '<C-CR>',  '<cmd>lua vim.lsp.buf.()<CR>', opts)
  map('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  map('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  map('n', '<leader>dl', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    map("n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright" }
for _, server in ipairs(servers) do
  lsp[server].setup { on_attach = on_attach }
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = "python", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
