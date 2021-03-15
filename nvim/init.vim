" The obvious                                                                       {{{1
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


" Color schemes
Plug 'arcticicestudio/nord-vim'
Plug 'gruvbox-community/gruvbox'

call plug#end()

" Settings                                                                          {{{1
" --------------------------------------------------------------------------------------
set clipboard=unnamed
set hidden
set termguicolors
set cpoptions+=$  " Vi-compatible options
set shortmess+=c  " suppress ins-completion-menu messages
set lazyredraw   " don't redraw screen while running macros
set number
set showmatch " highlight matching parens
set wildmode=longest:full,full

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


" Colors                                                                            {{{1
" --------------------------------------------------------------------------------------
colorscheme gruvbox


" Statusline                                                                        {{{1
" --------------------------------------------------------------------------------------
"
set statusline=
set statusline+=[%n]                       " Buffer Number
set statusline+=%y                         " file type
set statusline+=\ %q                       " Quick/Location list
set statusline+=\ %{fugitive#statusline()} " current branch
set statusline+=\ %f                       " path to file in buffer
set statusline+=%m%r%w                     " path (help, modified, read-only, preview)
set statusline+=%=                         " right align the rest
set statusline+=\ \ %(%l,%c%)              " row/col
set statusline+=\ \ %P                     " position in file %

" use rg for grepping
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m
endif

" Mappings                                                                          {{{1
" --------------------------------------------------------------------------------------
"

" Enter ex mode without shift
nnoremap , :
vnoremap , :

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
nnoremap <leader>sk :SlimuxSendKeysPrompt<CR>
nnoremap <leader>sr :SlimuxREPLConfigure<CR>

" LSP
lua require'lsp-config'

" FZF 
nmap <C-p> :FZF<CR>
nmap <Leader>ff :execute ":FZF " . expand('%:p:h')<CR>
nmap <Leader>fb :Buffers<CR>
nmap <Leader>fm :History<CR>
nmap <Leader>fg :Rg<CR>

