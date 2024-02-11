" shortcut for active file's directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

