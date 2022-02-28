augroup PjlDotfiles
  autocmd!
  autocmd BufRead **/dotfiles/** set modelines=5
  autocmd BufRead **/dotfiles/zsh/** set filetype=zsh
augroup end

augroup PjlFileTypes
augroup PjlQuickQuit
  autocmd!
  autocmd FileType quickfix,help nnoremap <buffer> q :q<CR>
augroup end
