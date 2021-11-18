local saga = require 'lspsaga'

saga.init_lsp_saga {
    use_saga_diagnostic_sign = true,
    error_sign = '✘',
    warn_sign = '',
    hint_sign = '',
    infor_sign = '!',
    dianostic_header_icon = '✘',
    code_action_icon = '',
    code_action_prompt = {
      enable = true,
      sign = true,
      sign_priority = 20,
      virtual_text = false,
    },
    code_action_keys = {
      quit = { '<Esc>', 'q' }, exec = '<CR>'  -- quit can be a table
    },
    rename_prompt_prefix = 'New name',
    rename_action_keys = {
      quit = { '<Esc>', 'q' }, exec = '<CR>'  -- quit can be a table
    },
    -- finder_definition_icon = '?  ',
    -- finder_reference_icon = '?  ',
    -- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
    -- finder_action_keys = {
    --   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
    -- },
    -- definition_preview_icon = '?  '
    -- "single" "double" "round" "plus"
    -- border_style = "single"
    -- if you don't use nvim-lspconfig you must pass your server name and
    -- the related filetypes into this table
    -- server_filetype_map = {metals = {'scala'}},
}