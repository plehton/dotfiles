augroup PjlDotfiles
  autocmd!
  autocmd BufRead **/dotfiles/** set modelines=5
  autocmd BufRead **/dotfiles/zsh/** set filetype=zsh
augroup end

" augroup PjlLineNumbers
"   autocmd!
"   autocmd InsertLeave * if &nu | set rnu   | endif
"   autocmd InsertEnter * if &nu | set nornu | endif
" augroup end


augroup PjlQuickQuit
  autocmd!
  autocmd FileType qf,help nnoremap <buffer> q :q<CR>
augroup end
