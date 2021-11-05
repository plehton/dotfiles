" Settings                                                                 {{{1
" -----------------------------------------------------------------------------
"
let mapleader = "\<Space>"
filetype plugin indent on
syntax enable

set clipboard=unnamed
set hidden
set history=1000
set belloff=all                             " No bells, ever

set number 
set relativenumber

" Backup & Undo
set nobackup nowritebackup                " skip backups completely
set noswapfile                            " don't write swap files
set undolevels=1000
set undofile
set undodir=~/.local/tmp/nvim/undo

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
set textwidth=80
set expandtab " tabs to spaces
set shiftwidth=4 " indent with spaces 
set softtabstop=4 " tab = 4 spaces

" fillchars
" set fillchars+=vert:│

" whitespace characters
"
set listchars=""
set listchars+=tab:⇥\  
set listchars+=space:·
set listchars+=eol:↵
set listchars+=lead:·
set listchars+=trail:·
set listchars+=extends:»
set listchars+=precedes:«
set nolist

" when wrap is on, break lines on linebreak characters,
" show symbol at the beginning of the line, 
" indent wrapped lines using shiftwidth amount of chars
" 
set breakindent
set linebreak
let &showbreak='↪ '
let &breakindentopt = 'sbr,shift:' . eval(&shiftwidth-2)

set termguicolors
let &colorcolumn='+' . join(range(0,200),',+')

set grepprg=rg\ --vimgrep\ --no-heading
set grepformat=%f:%l:%c:%m

"
" Plugins                                                                  {{{1 
" -----------------------------------------------------------------------------
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
Plug 'wincent/corpus'                   " Notes

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Programming
Plug 'nvim-lua/plenary.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'scalameta/nvim-metals'
Plug 'hashivim/vim-terraform'
Plug 'godlygeek/tabular'

" Color schemes
Plug 'chriskempson/base16-vim'

call plug#end()
