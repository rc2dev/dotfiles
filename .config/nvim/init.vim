"
" ~/.vimrc
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>
"

" This section needs to use single quotes.
call plug#begin()

Plug 'airblade/vim-rooter'
Plug 'ap/vim-css-color'
Plug 'aperezdc/vim-template'
Plug 'dense-analysis/ale'
Plug 'ferrine/md-img-paste.vim'
Plug 'Glench/Vim-Jinja2-Syntax'  " Syntax highlight for njk files
Plug 'goolord/alpha-nvim'
Plug 'junegunn/goyo.vim'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
Plug 'klen/nvim-config-local'
Plug 'nvim-lua/plenary.nvim'  " Dependency for telescope
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }  " Extension for telescope to use fzf as fuzzy finder
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-tree/nvim-web-devicons'  " Optional dependency for nvim-tree, for file icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'preservim/nerdcommenter'
Plug 'preservim/vim-markdown'
Plug 'ron89/thesaurus_query.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'wincent/loupe'

" Colorschemes
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'lifepillar/vim-solarized8'

call plug#end()

