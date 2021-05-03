local lsp= require('lspconfig')

require'compe'.setup {
  min_length = 1;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;
  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = false;
    spell = false;
    tags = false;
    vsnip = false;
    snippets_nvim = false;
    treesitter = true;
  };
}


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


_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
   --elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    --return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

_G.compe_confirm_enter = function()
    if vim.fn.pumvisible() == 1 then
        return vim.fn['compe#confirm']
    else
        return t "<CR>"
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<CR>", "v:lua.compe_confirm_enter()", {expr = true})
vim.api.nvim_set_keymap("s", "<CR>", "v:lua.compe_confirm_enter()", {expr = true})



local on_attach = function(client, bufnr)

  local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function setopt(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  setopt('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  map('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map('n', '<C-CR>',  '<cmd>lua vim.lsp.buf.()<CR>', opts)
  map('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
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
