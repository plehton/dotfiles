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


-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local cmp = require'cmp'
cmp.setup {
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
          { name = "buffer" },
          { name = "nvim_lsp" },
      }
  }

local on_attach = function(client, bufnr)

  local opts = { noremap=true, silent=true }
  local function map(key, val) vim.api.nvim_buf_set_keymap(bufnr, 'n', key, val, opts) end
  local function setopt(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  setopt('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  map('K'          , '<cmd>lua vim.lsp.buf.hover()<CR>'                       )
  map('<C-CR>'     , '<cmd>lua vim.lsp.buf.()<CR>'                            )
  map('<C-]>'      , '<cmd>lua vim.lsp.buf.definition()<CR>'                  )
  map('gd'         , '<cmd>lua vim.lsp.buf.definition()<CR>'                  )
  map('gr'         , '<cmd>lua vim.lsp.buf.references()<CR>'                  )
  map('[d'         , '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>'            )
  map(']d'         , '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>'            )
  map('<leader>d'  , '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
  map('<leader>dl' , '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>'          )
  map('<leader>rn' , '<cmd>lua vim.lsp.buf.rename()<CR>'                      )

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    map("n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
lsp["pyright"].setup { 
    on_attach = on_attach,
    capabilities = capabilities
}

-- nvim-metals
vim.g.metals_server_version = "0.10.7+119-90f26c65-SNAPSHOT"
metals_config = require("metals").bare_config()
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", 
    "com.github.swagger.akka.javadsl" },
}

metals_config.handlers["textDocument/publishDiagnostics"] 
    = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = { prefix = "E" },
})

metals_config.init_options.statusBarProvider = "on"

-- metals needs autogroup and it's easier to set it up here, since
-- we have the metals_config available 
vim.cmd [[
augroup LspMetals
    autocmd!
    autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc
    autocmd FileType scala lua require("metals").initialize_or_attach(metals_config)
    autocmd FileType scala setlocal completeopt=menu,noinsert,noselect
    autocmd FileType scala setlocal shortmess-=F shortmess+=c
augroup end
]]

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- metals_config.capabilities = capabilities
--
metals_config.on_attach = on_attach 
