call plug#begin('~/.vim/plugged')

Plug 'folke/tokyonight.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

set number
set nowrap
set tabstop=4
set shiftwidth=0
set expandtab

set foldlevel=20
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

colorscheme tokyonight

let g:netrw_liststyle = 3
let g:netrw_banner = 1
let g:netrw_browse_split = 3

map <C-p> <cmd>Files<cr>
map <C-f> <cmd>RG<cr>
map <C-w> <cmd>tabclose<cr>
map <C-e> <cmd>Explore<cr>
map <C-t> <cmd>tabnew<cr>
map <A-Right> <cmd>tabnext<cr>
map <A-Left> <cmd>-tabnext<cr>
