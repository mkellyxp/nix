call plug#begin('~/.vim/plugged')

Plug 'folke/tokyonight.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }


call plug#end()

set number
set nowrap
set tabstop=4
set shiftwidth=0
set expandtab

map <C-p> <cmd>Telescope find_files<cr>
map <C-f> <cmd>Telescope live_grep<cr>
map <C-w> <cmd>tabclose<cr>

colorscheme tokyonight

set foldlevel=20
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "html",
      "php",
      "javascript"
  },
  highlight = {
    enable = true,
  },
}
EOF
