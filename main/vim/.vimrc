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
" Syntax
Plug 'PotatoesMaster/i3-vim-syntax'
" Editing
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/yaifa.vim'
"Colorschemes
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

" Highlight current line in normal mode
set cursorline
autocmd InsertEnter,InsertLeave * set cursorline!

set showcmd                     " Show partial command
set noshowmode                  " Don't show modes below status line (redundant to Powerline)
set laststatus=2                " Always show status line
set showtabline=2               " Always show tab line
set splitbelow                  " Splitting puts new window below current


"======================================================================
" SYNTAX AND FILE TYPES
"======================================================================
" Enable syntax highlighting
if has("syntax")
	syntax on
endif

" Load indentation rules and plugin according to the detected filetype
if has("autocmd")
	filetype plugin indent on
endif

" Nginx syntax
autocmd BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif


"======================================================================
" TABS
"======================================================================
set tabstop=2
set shiftwidth=2
set noexpandtab

" Ruby: For some reason, I have to repeat my preferences for Ruby files
autocmd Filetype ruby setlocal noexpandtab tabstop=2 shiftwidth=2

" Python: 4 spaces soft tab
" (http://www.vex.net/~x/python_and_vim.html)
" softtabstop=4 makes backspace/delete operate over the 4 spaces at once
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4


"======================================================================
" FEATURES
"======================================================================
" Uncomment to have Vim jump to the last position when reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

set modeline                        " Enable modeline
set hidden                          " Allow buffers to be hidden without saving
set mouse=r                         " Make mouse copy/paste work
"set clipboard=unnamedplus          " Use clipboard as default register
set spelllang=pt_br,en_us,es_es     " Set spellcheck languages

function! AutoTrim()
	if !&binary && &filetype != 'diff'
		:%s/\s\+$//e                    " Remove trailing whitespace in every line
		:%s/^\n\+\%$//e                 " Remove blank lines at the end of the file
	endif
endfunction
autocmd BufWrite * call AutoTrim()  " Call AutoTrim when saving

" Turn on spell check for Git commits and use English
autocmd Filetype gitcommit,markdown setlocal spelllang=en_us spell

" Create the "tags" file (simply run ctags)
" NOW WE CAN: ^] to jump to tag under cursor; g^] for ambiguous tags; ^t to jump back up the tag stack
command! MakeTags !ctags -R .


"=======================================================================
" PLUGINS CONFIGURATION
"=======================================================================
" vim-closetag
" enable for *.erb
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb"


"=======================================================================
" SEARCH ON BUFFER
"=======================================================================
set ignorecase           " Do case insensitive matching
set smartcase            " Do smart case matching
set incsearch            " Incremental search


"=======================================================================
" COMMAND COMPLETION
"=======================================================================
set history=500          " Number of command lines remembered
set wildmode=longest,list,full
set wildmenu


"=======================================================================
" SHORTCUTS
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
nnoremap <Leader>e3 :e ~/.config/i3/config<CR>

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

