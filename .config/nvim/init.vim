"
" ~/.vimrc
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>
"

" This section needs to use single quotes.
call plug#begin()

Plug 'ahmedkhalf/project.nvim'

Plug 'ap/vim-css-color'

Plug 'aperezdc/vim-template'

Plug 'christoomey/vim-tmux-navigator'  " Needs plugin also on tmux.

Plug 'dense-analysis/ale'

Plug 'dhruvasagar/vim-table-mode'

Plug 'ferrine/md-img-paste.vim'

Plug 'gioele/vim-autoswap'

Plug 'Glench/Vim-Jinja2-Syntax'  " Syntax highlighting for njk files

Plug 'goolord/alpha-nvim'

Plug 'junegunn/goyo.vim'

Plug 'klen/nvim-config-local'

Plug 'nvim-lualine/lualine.nvim'

Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
  Plug 'nvim-lua/plenary.nvim'  " Dependency
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }  " Extension to use fzf as fuzzy finder

Plug 'nvim-tree/nvim-tree.lua'
  Plug 'nvim-tree/nvim-web-devicons' " Optional dependency, for file icons

Plug 'preservim/nerdcommenter'

Plug 'preservim/vim-markdown'

Plug 'ptzz/lf.vim'
  Plug 'voldikss/vim-floaterm'  " Must come after.

Plug 'ron89/thesaurus_query.vim'

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-sleuth'

Plug 'wincent/loupe'

" Colorschemes
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'

call plug#end()

