set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set guicursor=
set relativenumber
set cursorline
set nu
set nohlsearch
set hidden
set noerrorbells
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set colorcolumn=80
set signcolumn=yes
set noshowmode
set completeopt=menu,menuone,noselect

call plug#begin('~/.local/share/nvim/site/autoload')
" Color scheme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

" Apply color scheme
let g:tokyonight_style = "night"
colorscheme tokyonight
hi Normal ctermbg=NONE guibg=NONE

" Treesitter
luafile ~/.config/nvim/lua/treesitter.lua
