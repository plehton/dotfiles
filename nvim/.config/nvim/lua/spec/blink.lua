local icons = require('pjl.icons')
return {
  'saghen/blink.cmp',
  enabled = true,
  version = '1.*',
  opts = {
    keymap = { preset = 'default' },
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = {
      documentation = { auto_show = false },
      menu = {
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local icon = icons['kind'][ctx.kind]
                return icon
              end,
            }
          }
        }
      },
    },
    signature = { enabled = true },
    sources = {
      default = { 'lsp', 'path', 'buffer' },
      providers = {
        -- lazydev = {
        --     name = "LazyDev",
        --     module = "lazydev.integrations.blink",
        --     -- make lazydev completions top priority (see `:h blink.cmp`)
        --     score_offset = 100,
        -- }
      }
    },
    fuzzy = { implementation = "rust" },
  },
}
