" ~/.vimrc
"
" Author: Rafael Cavalcanti - rafaelc.org
"

" Don't mimic Vi
set nocompatible


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug automatic instalation (copied from vim-plug's github)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug (needs single quotes)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }   		" only load on demand
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'scrooloose/nerdcommenter'
Plug 'aperezdc/vim-template'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'tpope/vim-fugitive'
Plug 'ron89/thesaurus_query.vim'
" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" APPEARANCE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme
set termguicolors               " Use truecolors
set bg=dark
if hostname() == "localhost"
	colorscheme gruvbox
else
	colorscheme onedark
endif

" Interface
set showcmd                     " Show partial command
set noshowmode                  " Don't show modes below status line (redundant to Powerline)
set laststatus=2                " Always show status line
set showtabline=2               " Always show tab line
set splitbelow splitright       " Splitting puts new window right of / below current

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

" netrw: Hide dotfiles by default
let ghregex='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_list_hide=ghregex


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEHAVIOUR
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CODE STYLE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SPELL CHECK
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set default languages
set spelllang=pt_br,en_us,es_es

" Turn on for file types
autocmd Filetype gitcommit,markdown,text setlocal spell

" Set languages for specific files
autocmd Filetype gitcommit setlocal spelllang=en_us
autocmd BufRead,BufNewFile */Code/* setlocal spelllang=en_us


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-closetag
" Enable for *.erb
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb"

" vim-airline
" Show open buffers on top
let g:airline#extensions#tabline#enabled = 1

" vim-template
let g:templates_directory = ["$HOME/.vim/templates"]
let g:templates_no_builtin_templates = 1

" thesaurus_query
" Disable keymappings and set my own
let g:tq_map_keys = 0
nnoremap <Leader>ts :ThesaurusQueryReplaceCurrentWord<CR>
vnoremap <Leader>ts y:ThesaurusQueryReplace <C-r>"<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEYBINDINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap leader key
let mapleader="\<Space>"

" Clipboard operations
noremap <Leader>y "+y
noremap <Leader>d "+d
noremap <Leader>p "+p
set pastetoggle=<F2>

" Run current file
nnoremap <F5> :w<CR>:!%:p<CR>
inoremap <F5> <C-o>:w<CR><C-o>:!%:p<CR>

" Toggle spellcheck
nnoremap <F6> :setlocal spell!<CR>
inoremap <F6> <C-o>:setlocal spell!<CR>

" Buffer navigation
nnoremap <Leader><Leader> <C-^>
nnoremap <Leader>j :bp<CR>
nnoremap <Leader>k :bn<CR>

" Edit files
nnoremap <Leader>ev :e ~/.vimrc<CR>

" Save and quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>x :x<CR>

" Plugins
nnoremap <Leader>mp :MarkdownPreview<CR>
nnoremap <F12> :Goyo<CR>
inoremap <F12> <C-o>:Goyo<CR>
nnoremap <Leader>f :NERDTreeToggle<CR>
nnoremap <Leader>gs :Gstatus<CR>

" Navigate splits
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

" Resize splits
nnoremap <silent> <C-Left> :vertical resize +3<CR>
nnoremap <silent> <C-Right> :vertical resize -3<CR>
nnoremap <silent> <C-Up> :resize +3<CR>
nnoremap <silent> <C-Down> :resize -3<CR>

" Change 2 splits from/to vertical/horizontal
nnoremap <Leader>th <C-w>t<C-w>H
nnoremap <Leader>tv <C-w>t<C-w>K

" Close all splits but the current one
nnoremap <Leader>o <C-w>o

" Use friendlier line navigation on prose files
augroup navigation
	autocmd Filetype markdown,text nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
	autocmd Filetype markdown,text nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
	autocmd Filetype markdown,text nnoremap <Down> gj
	autocmd Filetype markdown,text nnoremap <Up> gk
	autocmd Filetype markdown,text nnoremap <Home> g<Home>
	autocmd Filetype markdown,text nnoremap <End> g<End>
augroup END

" Save as root and source ~/.vimrc
cmap w!! w !sudo tee % > /dev/null
cmap sv :so ~/.vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ABBREVIATIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab rca [RC added]
iab rcm [RC modified]
iab arc Copyright (C) <C-r>=strftime("%Y")<CR> Rafael Cavalcanti - rafaelc.org<CR>
iab cc Author: Rafael Cavalcanti - rafaelc.org



" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
	source /etc/vim/vimrc.local
endif

