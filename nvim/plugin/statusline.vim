set statusline=%!v:lua.require'pjl.statusline'.set()

augroup PjlStatusline
    autocmd!
    autocmd FocusGained,BufWinEnter,BufModifiedSet * lua require'pjl.statusline'.update()
augroup end
