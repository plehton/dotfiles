augroup PjlDotfiles
  autocmd!
  autocmd BufRead **/dotfiles/* set modelines=5
augroup end

augroup PjlColors
  autocmd!
  autocmd BufRead,BufWinEnter,VimEnter * let &l:colorcolumn='+' . join(range(0,200),',+')
augroup end
