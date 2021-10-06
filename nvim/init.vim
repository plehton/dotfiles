" Essentials                                                                       {{{1
" -------------------------------------------------------------------------------------
"
let mapleader = "\<Space>"
filetype plugin indent on
syntax enable

" Statusline                                                                       {{{1
" -------------------------------------------------------------------------------------
"

lua require'pjl.statusline'.set()

augroup PjlStatusline
    autocmd!
    autocmd BufWinEnter,BufModifiedSet * lua require'pjl.statusline'.check_modified()
augroup end

" Plugins                                                                          {{{1 
" -------------------------------------------------------------------------------------
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

" Plugin settings                                                                  {{{1
" -------------------------------------------------------------------------------------

luafile ~/.config/nvim/lua/config/lsp.lua
luafile ~/.config/nvim/lua/config/corpus.lua

