" Essentials                                                                        {{{1
" --------------------------------------------------------------------------------------
"
let mapleader = "\<Space>"
filetype plugin indent on
syntax enable


" Load plugins                                                                      {{{1 
" --------------------------------------------------------------------------------------
" 
"
call plug#begin(stdpath('data') . '/plugged')

Plug 'tpope/vim-unimpaired'             " Sane defaults for vim
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'

Plug 'machakann/vim-highlightedyank'    " Highlights yanked text
Plug 'romainl/vim-cool'                 " Disable highlight after searching
Plug 'christoomey/vim-tmux-navigator'   " Seamless switching between vim windows and tmux pane's
Plug 'epeli/slimux'                     " Send vim buffer contents to other tmux pane

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Programming
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

" Color schemes
Plug 'arcticicestudio/nord-vim'
Plug 'gruvbox-community/gruvbox'
Plug 'chriskempson/base16-vim'

call plug#end()

" Settings                                                                          {{{1
" --------------------------------------------------------------------------------------

set clipboard=unnamed
set hidden
set termguicolors
set shortmess+=c                          " suppress ins-completion-menu messages
set lazyredraw                            " don't redraw screen while running macros
set number 
set showmatch                             " highlight matching parens
set completeopt=menuone,longest,noselect  " always show menu, match longest common and force to select one
set wildmode=longest:full,full
set nobackup nowritebackup                " skip backups completely

set noincsearch
set ignorecase
set smartcase
set gdefault

set splitright
set splitbelow
set diffopt+=vertical
set scrolloff=3
set sidescrolloff=10
set sidescroll=5
set modelines=0

" t     Auto-wrap text using textwidth
" c     Auto-wrap comments
" q     Allow formatting of comments with gq
" j     Remove comment leader when joining lines
" r     Automatically insert comment leader after hitting <Enter>
set formatoptions=tcq1jr
set textwidth=88
set expandtab " tabs to spaces
set shiftwidth=4 " indent = spaces 
set softtabstop=4 " tab = 4 spaces

" whitespace characters
"
set listchars=""
set listchars+=tab:▸\
set listchars+=eol:¬
set listchars+=nbsp:·
set listchars+=trail:·
set listchars+=extends:»
set listchars+=precedes:«
set nolist

" use rg for grepping
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m
endif


" Colors                                                                            {{{1
" --------------------------------------------------------------------------------------
"colorscheme gruvbox

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

hi Statement gui=none


" Statusline                                                                        {{{1
"" --------------------------------------------------------------------------------------
""
"hi User1 gui=inverse,italic guibg=#665c54
"set statusline=
"" set statusline+=%1*\ %n\ %*                   " Buffer Number
"" set statusline+=\ %q                          " Quick/Location list
"" set statusline+=%1*\ %{fugitive#head()}\ %*   " current branch
"set statusline+=\ %m%r%w                        " path (help, modified, read-only, preview)
"set statusline+=\ %f                            " path to file in buffer
"set statusline+=\ %y                            " file type
"set statusline+=%=                              " right align the rest
"set statusline+=\ \ %P                          " position in file %
"set statusline+=\ %(%l\:%c%)                    " row/col

lua require'pjl.statusline'.set()

augroup PjlStatusline
    autocmd!
    autocmd BufWinEnter,BufModifiedSet * lua require'pjl.statusline'.check_modified()
augroup end

" Mappings                                                                          {{{1
" --------------------------------------------------------------------------------------
"

" Enter ex mode without shift
nnoremap , :
vnoremap , :

" 
nnoremap <leader>o <C-^>

" Edit dotfiles 
nnoremap <leader>ev :execute ":e $MYVIMRC"<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ez :e ~/.zshrc<CR>
nnoremap <leader>et :e ~/.tmux.conf<CR>

" command mode shortcut for active file's directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'



" Plugin settings                                                                   {{{1
" --------------------------------------------------------------------------------------

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

" LSP
luafile ~/.config/nvim/lua/config/lsp.lua

" FZF 
nmap <C-p> :FZF<CR>
nmap <Leader>ff :execute ":FZF " . expand('%:p:h')<CR>
nmap <Leader>fb :Buffers<CR>
nmap <Leader>fm :History<CR>
nmap <Leader>fg :Rg<CR>
nmap <Leader>fw :execute ":Rg " . expand('<cword>')<CR>

