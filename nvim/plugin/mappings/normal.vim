" ex mode without shift
nnoremap , :

" 
" double leader changes to alternate file 
nnoremap <leader><leader> <C-^>

nnoremap <leader>o :only<CR>

" Open/Close folds with Tab
nnoremap <Tab> za

" Relying on Karabiner-Elements (macOS) or Interception Tools (Linux) to avoid
" collision between <Tab> and <C-i> (have it send F6 instead for <C-i>).
" source: Greg Hurrell
nnoremap <F6> <C-i>

" Edit dotfiles 
nnoremap <leader>ev :execute ":e $MYVIMRC"<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ez :e ~/.zshrc<CR>
nnoremap <leader>et :e ~/.tmux.conf<CR>

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
nnoremap <leader>sc :SlimuxREPLConfigure<CR>

" Telescope 
nnoremap <C-p> :Telescope find_files<CR>
nnoremap <Leader>ff :execute ':Telescope find_files cwd=' . expand('%:p:h')<CR>
nnoremap <Leader>fb :Telescope buffers<CR>
nnoremap <Leader>fm :Telescope oldfiles<CR>
nnoremap <Leader>lg :Telescope live_grep<CR>
nnoremap <Leader>fw :Telescope grep_string<CR>


