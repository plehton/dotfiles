" Settings                                                                         
" -------------------------------------------------------------------------------------

set clipboard=unnamed
set hidden
set history=1000
set belloff=all                           " No bells, ever

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
set textwidth=88
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

set breakindent
let &showbreak='↪ '
let &breakindentopt = 'sbr,shift:' . eval(&shiftwidth-2)

set termguicolors
let &l:colorcolumn='+' . join(range(0,200),',+')

set grepprg=rg\ --vimgrep\ --no-heading
set grepformat=%f:%l:%c:%m
