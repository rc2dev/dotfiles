"
" ~/.vimrc
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>
"

" vim-plug (needs single quotes)
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-sleuth'
Plug 'preservim/nerdcommenter'
Plug 'aperezdc/vim-template'
Plug 'tpope/vim-fugitive'
Plug 'ron89/thesaurus_query.vim'
Plug 'ap/vim-css-color'
Plug 'ferrine/md-img-paste.vim'
Plug 'preservim/vim-markdown'
Plug 'francoiscabrol/ranger.vim'
" Dependency for ranger.vim to replace netrw
Plug 'rbgrouleff/bclose.vim'
Plug 'airblade/vim-rooter'
Plug 'embear/vim-localvimrc'
Plug 'wincent/loupe'
Plug 'dense-analysis/ale'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
call plug#end()

