" Enter ex mode without shift
nnoremap , :
vnoremap , :

" 
nnoremap <leader>o <C-^>

" Open/Close folds with Tab
nnoremap <Tab> za

" Relying on Karabiner-Elements (macOS) or Interception Tools (Linux) to avoid
" collision between <Tab> and <C-i> (have it send F6 instead for <C-i>).
nnoremap <F6> <C-i>

" Edit dotfiles 
nnoremap <leader>ev :execute ":e $MYVIMRC"<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ez :e ~/.zshrc<CR>
nnoremap <leader>et :e ~/.tmux.conf<CR>

" command mode shortcut for active file's directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Arrows mapped to quicklist
nnoremap <silent> <Up> :cprevious<CR>
nnoremap <silent> <Down> :cnext<CR>
nnoremap <silent> <Left> :cpfile<CR>
nnoremap <silent> <Right> :cnfile<CR>

" fugitive
nnoremap <leader>g :G<CR>
nnoremap <leader>ge :Ge:<CR>

" Slimux 
nnoremap <leader>sl :SlimuxREPLSendLine<CR>
nnoremap <leader>sp :SlimuxREPLSendParagraph<CR>
nnoremap <leader>sb :SlimuxREPLSendBuffer<CR>
vnoremap <leader>sv :SlimuxREPLSendSelection<CR>
nnoremap <leader>sp :SlimuxSendKeysPrompt<CR>
nnoremap <leader>sc :SlimuxREPLConfigure<CR>

" FZF 
nnoremap <C-p> :FZF<CR>
nnoremap <Leader>ff :execute ":FZF " . expand('%:p:h')<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fm :History<CR>
nnoremap <Leader>fg :Rg<CR>
nnoremap <Leader>fw :execute ":Rg " . expand('<cword>')<CR>

