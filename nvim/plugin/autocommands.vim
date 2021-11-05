augroup PjlDotfiles
  autocmd!
  autocmd BufRead **/dotfiles/* set modelines=5
augroup end

augroup PjlColors
  autocmd!
  autocmd BufNew,BufRead,BufWinEnter,VimEnter * call v:lua.require('pjl.autocommands').colorcolumn
augroup end
