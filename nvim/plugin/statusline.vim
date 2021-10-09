lua require'pjl.statusline'.set()

augroup PjlStatusline
    autocmd!
    autocmd BufWinEnter,BufModifiedSet * lua require'pjl.statusline'.check_modified()
augroup end
