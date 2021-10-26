augroup PjlDotfiles
  autocmd!
  autocmd BufRead **/dotfiles/* set modelines=5
augroup end

augroup PjlColors
  autocmd!
  autocmd BufNew, BufRead, BufWinEnter,VimEnter * let &colorcolumn='+' . join(range(0,200),',+')
augroup end
