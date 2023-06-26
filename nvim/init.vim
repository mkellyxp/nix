call plug#begin('~/.vim/plugged')

Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'prettier/vim-prettier', { 'do': 'npm install', 'for': ['php'] }

call plug#end()

lua require('config/treesitter')
autocmd BufWritePre *.php PrettierAsync

set number
set nowrap
set tabstop=4
set shiftwidth=0
set expandtab

set foldlevel=20
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

colorscheme catppuccin

let g:netrw_liststyle = 3
let g:netrw_banner = 1
let g:netrw_browse_split = 3

map <C-p> <cmd>Files<cr>
map <C-f> <cmd>RG<cr>
map <C-w> <cmd>q<cr>
map <C-e> <cmd>Explore<cr>
map <C-t> <cmd>tabnew<cr>
map <C-s> <cmd>w<cr>

map <A-Right> <cmd>tabn<cr>
map <A-Left> <cmd>tabp<cr>

map <A-1> 1gt
map <A-2> 2gt
map <A-3> 3gt
map <A-4> 4gt
map <A-5> 5gt
map <A-6> 6gt
map <A-7> 7gt
map <A-8> 8gt
map <A-9> 9gt

map <A-S-Left> <cmd>-tabm<cr>
map <A-S-Right> <cmd>+tabm<cr>
