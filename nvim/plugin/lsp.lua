local lsp = require('lspconfig')

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
-- this is from metals config sample
capabilities.textDocument.completion.completionItem.snippetSupport = true

local cmp = require'cmp'
cmp.setup {
  snippet = { expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      },
      sources = {
          { name = "nvim_lsp" },
          { name = "vsnip" },
      }
  }

local on_attach = function(client, bufnr)

  local opts = { noremap=true, silent=true }
  local function map(mode, key, val) vim.api.nvim_buf_set_keymap(bufnr, mode, key, val, opts) end
  local function setopt(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  setopt('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  map('n', 'K'         , '<cmd>lua vim.lsp.buf.hover()<CR>')
  map('n', '<C-]>'     , '<cmd>lua vim.lsp.buf.definition()<CR>')
  map('n', 'gd'        , '<cmd>lua vim.lsp.buf.definition()<CR>')
  map('n', 'gr'        , '<cmd>lua vim.lsp.buf.references()<CR>')

  map('n', '<leader>a' , '<cmd>lua require(\'lspsaga.codeaction\').code_action()<CR>')
  map('n', '<leader>r' , '<cmd>lua require(\'lspsaga.rename\').rename()<CR>')
  map('n', '<leader>=' , '<cmd>lua vim.lsp.buf.formatting()<CR>')
  map('v', "<leader>=" , '<cmd>lua vim.lsp.buf.range_formatting()<CR>')

  map('n', '[d'        , '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
  map('n', ']d'        , '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  map('n', '<leader>e' , '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})<CR>')
  map('n', '<leader>ee', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')

  -- vim.cmd([[augroup PjlLspOnAttach]])
  -- vim.cmd([[autocmd!]])
  -- vim.cmd([[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
  -- vim.cmd([[augroup end]])

  -- Need for symbol highlights to work correctly
  -- vim.cmd([[hi! link LspReferenceText NonText]])
  -- vim.cmd([[hi! link LspReferenceRead NonText]])
  -- vim.cmd([[hi! link LspReferenceWrite NonText]])

  -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  --                  vim.lsp.handlers.hover, {
  --                    -- Use a sharp border with `FloatBorder` highlights
  --                    border = "single"
  --                  }
  --                )
  --
end

lsp["pyright"].setup { 
    on_attach = on_attach,
    capabilities = capabilities
}

-- nvim-metals
metals_config = require("metals").bare_config()
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = {},
}
metals_config.handlers["textDocument/publishDiagnostics"] 
  = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, 
  { virtual_text = { prefix = "! " }, })

metals_config.init_options.statusBarProvider = "on"

metals_config.capabilities = capabilities
metals_config.on_attach = on_attach 

vim.cmd([[
augroup PjlLspMetals
    autocmd!
    autocmd FileType scala lua require("metals").initialize_or_attach(metals_config)
augroup end
]])

