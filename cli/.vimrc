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
Plug 'powerline/powerline', { 'rtp': 'powerline/bindings/vim/' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }   		" only load on demand
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-sleuth'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'scrooloose/nerdcommenter'
" Colorschemes
Plug 'hzchirs/vim-material'
Plug 'lu-ren/SerialExperimentsLain'
Plug 'w0ng/vim-hybrid'
call plug#end()


"======================================================================
" APPEARANCE
"======================================================================
" If both terminal and VIM support truecolor
if $COLORTERM == "truecolor" && has("termguicolors")
	set termguicolors             " Use truecolors
	colorscheme vim-material      " This colorscheme needs truecolor
else
	set bg=dark
	colorscheme industry
endif

set nu
set relativenumber
set linebreak                   " More inteligent wrapping (don't break words)
set scrolloff=10                " Minimum lines below cursor
set showmatch                   " Show matching brackets
set showcmd                     " Show partial command
set noshowmode                  " Don't show modes below status line (redundant to Powerline)
set laststatus=2                " Always show status line
set showtabline=2               " Always show tab line
set splitbelow                  " Splitting puts new window below current

" Highlight current line in normal mode
set cursorline
autocmd InsertEnter,InsertLeave * set cursorline!


"======================================================================
" BEHAVIOUR
"======================================================================
set modeline                    " Enable modeline
set hidden                      " Allow buffers to be hidden without saving
set mouse=r                     " Make mouse copy/paste work

" Create tags file (this just runs ctags). This allows:
" ^] to jump to tag under cursor; g^] for ambiguous tags; ^t to jump back up the tag stack
command! MakeTags !ctags -R .

" Search
set ignorecase                  " Do case insensitive matching
set smartcase                   " Do smart case matching
set incsearch                   " Incremental search

" Command completion
set history=500                 " Number of command lines remembered
set wildmode=longest,list,full
set wildmenu


"======================================================================
" SYNTAX
"======================================================================
" Enable syntax highlighting
syntax on

" Nginx syntax
autocmd BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif


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
" CODE LINTING
"======================================================================
" Call shellcheck on saving sh files
autocmd BufWritePost * if &ft == 'sh' | !shellcheck % ^@  endif

" Set spell check languages
set spelllang=pt_br,en_us,es_es

" Turn on spell check for Git commits and use English
autocmd Filetype gitcommit,markdown setlocal spelllang=en_us spell


"=======================================================================
" PLUGINS CONFIGURATION
"=======================================================================
" vim-closetag
" enable for *.erb
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb"


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

" Go to next buffer
nnoremap <Leader>l :bn<CR>|

" Toggle spellcheck
map <F6> :setlocal spell!<CR>|

" Save as root
cmap w!! w !sudo tee % > /dev/null

" Panels operations
nnoremap <Leader>w <C-w>
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Edit preset files
nnoremap <Leader>ev :e ~/.vimrc<CR>

" Use friendlier line navigation on prose files
autocmd Filetype markdown noremap j gj
autocmd Filetype markdown noremap k gk
autocmd Filetype markdown noremap <Down> gj
autocmd Filetype markdown noremap <Up> gk
autocmd Filetype markdown noremap <Home> g<Home>
autocmd Filetype markdown noremap <End> g<End>

" Nerdtree (default: <C-n>)
nnoremap <Leader>f :NERDTreeToggle<CR>


"=======================================================================
" ABBREVIATIONS
"=======================================================================
iab rcc [RC]
iab rca [RC added]
iab rcm [RC modified]


" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
	source /etc/vim/vimrc.local
endif

