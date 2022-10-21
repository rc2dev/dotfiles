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
Plug 'embear/vim-localvimrc'
Plug 'ferrine/md-img-paste.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'preservim/nerdcommenter'
Plug 'preservim/vim-markdown'
Plug 'rbgrouleff/bclose.vim'  " Dependency for ranger.vim to replace netrw
Plug 'ron89/thesaurus_query.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'vim-airline/vim-airline'
Plug 'wincent/loupe'

call plug#end()
