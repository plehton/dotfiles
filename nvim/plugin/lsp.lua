local lsp = require('lspconfig')

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

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
        ['<C-u>'] = cmp.mapping.scroll_docs(-5),
        ['<C-d>'] = cmp.mapping.scroll_docs(5),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      },
      sources = {
          { name = "nvim_lsp" },
          { name = "vsnip" },
          { name = "path" },
      }
  }

local on_attach = function(client, bufnr)

  local opts = { noremap=true, silent=true }
  local function map(mode, key, val) vim.api.nvim_buf_set_keymap(bufnr, mode, key, val, opts) end
  local function setopt(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  setopt('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  map('n', 'K'         , '<cmd>lua vim.lsp.buf.hover()<CR>')
  map('n', 'gd'        , '<cmd>lua vim.lsp.buf.definition()<CR>')
  map('n', 'gr'        , '<cmd>lua vim.lsp.buf.references()<CR>')

  map('n', '<leader>a' , '<cmd>lua vim.lsp.buf.code_action()<CR>')
  map('n', '<leader>r' , '<cmd>lua vim.lsp.buf.rename()<CR>')
  map('n', '<leader>=' , '<cmd>lua vim.lsp.buf.format()<CR>')

  map('n', '[d'        , '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  map('n', ']d'        , '<cmd>lua vim.diagnostic.goto_next()<CR>')
  map('n', '<leader>e' , '<cmd>lua vim.diagnostic.open_float()<CR>')
  map('n', '<leader>ee', '<cmd>lua vim.diagnostic.setqflist()<CR>')

  local signs = { Error = '栗', Warn = '', Hint = '', Info = '' }

  for sign, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. sign
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
  end

  require "lsp_signature".on_attach({
    bind = true,
    doc_lines = 0,
    hint_enable = true,
    hint_prefix = "<< ",
    hi_parameter = "Underlined",
    floating_window = true,
    }
  )

end

local handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        { virtual_text = false, 
          -- signs = { priority = 50 }, 
          underline = true, 
          update_in_insert = false 
        }
    )
}


lsp["pyright"].setup { 
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers
}

-- nvim-metals
metals_config = require("metals").bare_config()
metals_config = {
    init_options = { statusBarProvider = "on" },
    settings = {
      showImplicitArguments = true,
      excludedPackages = {},
    },
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers
}

local metals_augroup = "pjl-lsp-metals"
vim.api.nvim_create_augroup(metals_augroup, { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
    group = metals_augroup,
    pattern = { "scala", "sbt", "java" },
    callback = function()
        require("metals").initialize_or_attach(metals_config)
    end
})

