" Essentials                                                                        {{{1
" --------------------------------------------------------------------------------------
"
let mapleader = "\<Space>"
filetype plugin indent on
syntax enable


" Plugins                                                                           {{{1 
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

Plug 'wincent/corpus'

" Programming
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'hashivim/vim-terraform'
Plug 'godlygeek/tabular'

" Color schemes
Plug 'arcticicestudio/nord-vim'
Plug 'gruvbox-community/gruvbox'
Plug 'chriskempson/base16-vim'

call plug#end()

" Plugin settings                                                                   {{{1
" --------------------------------------------------------------------------------------

luafile ~/.config/nvim/lua/config/lsp.lua
luafile ~/.config/nvim/lua/config/corpus.lua

" Settings                                                                          {{{1
" --------------------------------------------------------------------------------------

set clipboard=unnamed
set hidden
set termguicolors
set number 
set relativenumber
set nobackup nowritebackup                " skip backups completely
set shortmess+=c                          " suppress ins-completion-menu messages
set lazyredraw                            " don't redraw screen while running macros
set showmatch                             " highlight matching parens
set completeopt=menuone,noselect          " always show menu, match longest common and force to select one
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
set shiftwidth=4 " indent with spaces 
set softtabstop=4 " tab = 4 spaces

" whitespace characters
"
set listchars=""
set listchars+=tab:???\
set listchars+=eol:??
set listchars+=nbsp:??
set listchars+=trail:??
set listchars+=extends:??
set listchars+=precedes:??
set nolist

set grepprg=rg\ --vimgrep\ --no-heading
set grepformat=%f:%l:%c:%m


" Colors set using base16                                                           {{{1
" --------------------------------------------------------------------------------------

let base16colorspace=256
source ~/.vimrc_background

" hi Statement gui=none


" Statusline                                                                        {{{1
"" --------------------------------------------------------------------------------------
""

lua require'pjl.statusline'.set()

augroup PjlStatusline
    autocmd!
    autocmd BufWinEnter,BufModifiedSet * lua require'pjl.statusline'.check_modified()
augroup end

