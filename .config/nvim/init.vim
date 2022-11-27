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

let mapleader = " "

" Plugins
call plug#begin('~/.local/share/nvim/site/autoload')
" Styling
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" NERDTree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons' " needs to be loaded after nerdtree and lightline.vim
" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }
" REPL
Plug 'jpalardy/vim-slime'
" Debugger
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'mfussenegger/nvim-dap-python'
call plug#end()

set completeopt=menu,menuone,noselect

" Apply color scheme
let g:tokyonight_style = 'night'
colorscheme tokyonight
hi Normal ctermbg=NONE guibg=NONE
let g:airline_theme = 'deus'

" Treesitter
luafile ~/.config/nvim/lua/treesitter.lua

" NERDTree
nnoremap <leader>n <cmd>NERDTreeToggle<cr>

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>dl <cmd>Telescope diagnostics<cr>

" LSP
luafile ~/.config/nvim/lua/lsp-config.lua

" REPL
let g:slime_target = "tmux"
let g:slime_bracketed_paste = 1
let g:slime_default_config = { "socket_name": "default", "target_pane": "{right-of}" }

" Debugger
lua require('dap-python').setup('~/.venvs_global/debugpy/bin/python')
lua require('nvim-dap-virtual-text').setup()
lua require('dapui').setup()
"PyInt_FromLong not found: https://github.com/microsoft/vscode-python/issues/20253

lua << EOF
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
EOF

nnoremap <silent> <leader>B <cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>b <cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dc <cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <leader>sn <cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>si <cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>se <cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>dr <cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>
vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
