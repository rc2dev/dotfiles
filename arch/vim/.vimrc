" ~/.vimrc
"
" Autor: Rafael Cavalcanti
"

set nocompatible				" Don't try to mimic Vi


" vim-plug
"=======================================================================
" Note: needs single quotes
call plug#begin('~/.vim/plugged')		" Specify a directory for plugins
Plug 'powerline/powerline', { 'rtp': 'powerline/bindings/vim/' }	" option needed
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }   		" load only on demand
Plug 'vimwiki/vimwiki'
Plug 'mrtazz/simplenote.vim'
" Syntax
Plug 'joanrivera/vim-zimwiki-syntax'
Plug 'PotatoesMaster/i3-vim-syntax'
" Editing
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'scrooloose/nerdcommenter'
 "Colorschemes
Plug 'hzchirs/vim-material'
Plug 'jakwings/vim-colors'
Plug 'lu-ren/SerialExperimentsLain'
Plug 'exitface/synthwave.vim'
Plug 'w0ng/vim-hybrid'
call plug#end()


" APPEARANCE
"=========================================================================
if $COLORTERM == "truecolor"    " If terminal supports truecolor
	set termguicolors             " Use truecolors
	colorscheme vim-material      " This colorscheme needs truecolor
"	colorscheme hybrid
else
	set bg=dark
	colorscheme industry
endif

set nu
set relativenumber
"set colorcolumn=80																				" Show vertical line
"highlight ColorColumn ctermbg=lightgrey guibg=lightgrey 	" Line colour
set linebreak                   " More inteligent wrapping (don't break words)
set scrolloff=10                " Minimum lines below cursor
set showmatch                   " Show matching brackets

" Highlight current line in normal mode
set cursorline
autocmd InsertEnter,InsertLeave * set cursorline!

" Set colors for highlighting current line
"highlight CursorLine cterm=none ctermbg=239 ctermfg=white
" Set colors for insert mode completion (^X)
"highlight Pmenu ctermbg=238 ctermfg=white

set showcmd                     " Show partial command
set noshowmode                  " Don't show modes below status line (redundant to Powerline)
set laststatus=2                " Always show status line
set showtabline=2               " Always show tab line
set splitbelow                  " Splitting puts new window below current


" SYNTAX AND FILE TYPES
"=======================================================================
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
" Zim Wiki syntax
autocmd BufRead,BufNewFile $HOME/Private/Notebooks/* set filetype=zimwiki


" TABS
"=======================================================================
set tabstop=2
set shiftwidth=2
set noexpandtab

" Python: 4 spaces hard tab (softtabstop=4 faz backspace/delete excluir os 4 espaços de uma vez)
" (http://www.vex.net/~x/python_and_vim.html)
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4


" FEATURES
"=======================================================================
" Uncomment to have Vim jump to the last position when reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

set modeline                        " Enable modeline
set hidden                          " Allow buffers to be hidden without saving
set mouse=r                         " (Não sei por quẽ) Fazer copia/cola do mouse funcionar
"set clipboard=unnamedplus							" Use clipboard as default register
set spelllang=pt_br,en_us           " Set spellcheck languages
autocmd BufWrite * :%s/\s\+$//e     " When saving, remove trailing whitespace in every line
autocmd BufWrite * :%s/^\n\+\%$//e  " When saving, remove blank lines at the end of the file

" Turn on spell check for Git commits and use English
autocmd Filetype gitcommit setlocal spelllang=en_us spell


" PLUGINS CONFIGURATION
"=======================================================================
" vim-closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb"	"enable it in erb files

" teste
"let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]


" SEARCH ON BUFFER
"=======================================================================
set ignorecase           " Do case insensitive matching
set smartcase            " Do smart case matching
set incsearch            " Incremental search


" COMMAND COMPLETION
"=======================================================================
set history=500          " Number of command lines remembered
set wildmode=longest,list,full
set wildmenu
"set path+=**											" :find to search files recursively


" SHORTCUTS
"=======================================================================
" Clipboard operations
noremap <Leader>y "+y
noremap <Leader>d "+d
noremap <Leader>p "+p
set pastetoggle=<F2>

" Buffer operations
nnoremap <Leader>l :bn<CR>|                      " Go to next buffer
" Maps useful for when working in split windows. Current buffer in full window.
nnoremap <Leader>to :tabedit %<CR>|              " Open current buffer on tab
nnoremap <Leader>tc :tabclose %<CR>|             " Close current tab
cmap w!! w !sudo tee > /dev/null %							 " Save as root

" Panels operations
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

map <F6> :setlocal spell!<CR>|                   " Toggle spellcheck

" Edit preset files
nnoremap <Leader>ev :e ~/.vimrc<CR>|             " Open ~/.vimrc
nnoremap <Leader>e3 :e ~/.config/i3/config<CR>|  " Open i3 config

" Addons
nnoremap <Leader>f :NERDTreeToggle<CR>|          " Nerdtree (original: <C-n>)

" Create the "tags" file (simply run ctags)
" NOW WE CAN: ^] to jump to tag under cursor; g^] for ambiguous tags; ^t to jump back up the tag stack
command! MakeTags !ctags -R .


" ABBREVIATIONS
"=======================================================================
iab rca [RC added]
iab rcr [RC removed]
iab rcm [RC modified]


" SWAP
"=======================================================================
" Set a safe directory for swapfiles, so my SSD or memory card isn't
" destroyed.
" Note: "Using double trailing slashes in the path tells vim to enable a feature
" where it avoids name collisions."
"silent !mkdir -p ~/.cache/vim_swap > /dev/null 2>&1
set directory=$HOME/.cache/vim_swap//,/tmp//


" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif


let g:vimwiki_list = [{'path': '~/vimwiki/',
  \ 'path_html': '~/vimwiki_html/',
  \ 'syntax': 'markdown',
  \ 'ext': '.md',
  \ 'custom_wiki2html': '~/convert.sh'}]

source ~/.vim/simplenoterc

