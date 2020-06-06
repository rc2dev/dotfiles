" ~/.vimrc
"
" Author: Rafael Cavalcanti
"

" Don't mimic Vi
set nocompatible


"======================================================================
" vim-plug automatic instalation (copied from vim-plug's github)
"======================================================================
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


"======================================================================
" vim-plug (needs single quotes)
"======================================================================
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }   		" only load on demand
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-sleuth'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'scrooloose/nerdcommenter'
Plug 'aperezdc/vim-template'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'tpope/vim-fugitive'
" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
call plug#end()


"======================================================================
" APPEARANCE
"======================================================================
" Theme
set termguicolors               " Use truecolors
colorscheme onedark
set bg=dark

" Interface
set showcmd                     " Show partial command
set noshowmode                  " Don't show modes below status line (redundant to Powerline)
set laststatus=2                " Always show status line
set showtabline=2               " Always show tab line
set splitbelow                  " Splitting puts new window below current
set splitright

" Editor
set nu
set relativenumber
set linebreak                   " More inteligent wrapping (don't break words)
set scrolloff=10                " Minimum lines below cursor
set showmatch                   " Show matching brackets
" Show tabs and trailing spaces
set list listchars=tab:→\ ,trail:·
" Highlight current line in normal mode
set cursorline
autocmd InsertEnter,InsertLeave * set cursorline!

" Enable syntax highlighting
syntax on

"======================================================================
" BEHAVIOUR
"======================================================================
set modeline                    " Enable modeline
set hidden                      " Allow buffers to be hidden without saving
set mouse=a                     " Enable the use of the mouse

" Create tags file (this just runs ctags). This allows:
" ^] to jump to tag under cursor; g^] for ambiguous tags; ^t to jump back up the tag stack
command! MakeTags !ctags -R .

" Search
set ignorecase                  " Do case insensitive matching
set smartcase                   " Do smart case matching
set incsearch                   " Incremental search

" Command completion
set history=500                 " Number of command lines remembered
set wildmenu

" Open quickfix automatically (for shellcheck)
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Put swap files in one directory. Fallback to working dir.
silent !mkdir -p ~/.vim/swap
set directory=$HOME/.vim/swap//,.

"======================================================================
" CODE STYLE
"======================================================================
" Load indentation rules and plugin according to the detected filetype
filetype plugin indent on

" Default indentation
set tabstop=2
set shiftwidth=2
set expandtab

" Trim whitespace when saving
function! AutoTrim()
	if !&binary && &filetype != 'diff'
		:%s/\s\+$//e                    " Remove trailing whitespace in every line
		:%s/^\n\+\%$//e                 " Remove blank lines at the end of the file
	endif
endfunction
autocmd BufWrite * call AutoTrim()

"======================================================================
" SPELL CHECK
"======================================================================
" Set default languages
set spelllang=pt_br,en_us,es_es

" Turn on for file types
autocmd Filetype gitcommit,markdown setlocal spell

" Set languages for specific files
autocmd Filetype gitcommit setlocal spelllang=en_us
autocmd BufRead,BufNewFile */Code/* setlocal spelllang=en_us

"=======================================================================
" PLUGINS CONFIGURATION
"=======================================================================
" vim-closetag
" Enable for *.erb
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb"

" vim-airline
" Show open buffers on top
let g:airline#extensions#tabline#enabled = 1

" vim-template
let g:templates_directory = ["$HOME/.vim/templates"]

"=======================================================================
" KEYBINDINGS
"=======================================================================
" Remap leader key
let mapleader="\<Space>"

" Clipboard operations
noremap <Leader>y "+y
noremap <Leader>d "+d
noremap <Leader>p "+p
set pastetoggle=<F2>

" Run current file
map <F5> <Esc>:w<CR>:vertical terminal %:p<CR>
" Toggle spellcheck
map <F6> :setlocal spell!<CR>
" Go to next buffer
nnoremap <Leader>l :bn<CR>
" Markdown preview
nnoremap <Leader>mp :MarkdownPreview<CR>
" Nerdtree (default: <C-n>)
nnoremap <Leader>f :NERDTreeToggle<CR>
" VIM Fugitive
nnoremap <Leader>gs :Gstatus<CR>
" Edit and source files
nnoremap <Leader>ev :e ~/.vimrc<CR>
command Sv :so ~/.vimrc


" Panels operations
nnoremap <Leader>w <C-w>
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Use friendlier line navigation on prose files
augroup navigation
	autocmd Filetype markdown noremap j gj
	autocmd Filetype markdown noremap k gk
	autocmd Filetype markdown noremap <Down> gj
	autocmd Filetype markdown noremap <Up> gk
	autocmd Filetype markdown noremap <Home> g<Home>
	autocmd Filetype markdown noremap <End> g<End>
augroup END

" Save as root
cmap w!! w !sudo tee % > /dev/null


"=======================================================================
" ABBREVIATIONS
"=======================================================================
iab rcc [RC]
iab rca [RC added]
iab rcm [RC modified]
iab cc  Copyright (C) <C-r>=strftime("%Y")<CR> Rafael Cavalcanti - rafaelc.org<CR>
	\Licensed under GPLv3



" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
	source /etc/vim/vimrc.local
endif

