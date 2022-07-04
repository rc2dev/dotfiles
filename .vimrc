" vim:fdm=marker:fdl=0:foldenable
"
" ~/.vimrc
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>
"

" Don't mimic Vi
set nocompatible


" vim-plug (needs single quotes) {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'aperezdc/vim-template'
Plug 'tpope/vim-fugitive'
Plug 'ron89/thesaurus_query.vim'
Plug 'ap/vim-css-color'
Plug 'ferrine/md-img-paste.vim'
Plug 'plasticboy/vim-markdown'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'                        " Dependency for ranger.vim to replace netrw
Plug 'airblade/vim-rooter'
Plug 'embear/vim-localvimrc'
Plug 'wincent/loupe'
Plug 'dense-analysis/ale'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
set noshowmode                                      " Don't show modes below status line (redundant to Airline)
if hostname() == 'rd'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

call plug#end()


" APPEARANCE {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:SetTransparency()
  " Don't do it on gvim or it will get messed up
  if has('gui_running')
    return
  endif

  let l:theme_guibg = synIDattr(hlID('Normal'), 'bg')
  hi Normal guibg=NONE ctermbg=NONE
  " Fix :terminal having black background after the above command.
  execute 'hi Terminal guibg=' . l:theme_guibg
endfunction

augroup appearance
  autocmd!

  autocmd ColorScheme * call <SID>SetTransparency()

 " For dracula theme, make tab chars more subtle
 autocmd ColorScheme dracula hi! link SpecialKey DraculaComment

  " Resize splits automatically if VIM is resized
  autocmd VimResized * execute "normal! \<C-w>="
augroup END

" Theme (must come after autocmd for transparency)
set termguicolors                                   " Use truecolors
" We won't have the theme on first run
try
  colorscheme dracula
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme desert
endtry
set bg=dark

" Fix colors on st
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Use different cursor for insert/normal mode
" Adapted from <https://stackoverflow.com/a/42118416>
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
" Reset the cursor on start
augroup cursor
  au!
  autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" Interface
set shortmess+=I                                    " Disable startup message
set showcmd                                         " Show partial command
set laststatus=2                                    " Always show status line
set showtabline=2                                   " Always show tab line
set splitbelow splitright                           " Splitting puts new window right of / below current

" Editor
syntax on                                           " Enable syntax highlighting
set number
set relativenumber
set scrolloff=10                                    " Minimum lines below cursor
set showmatch                                       " Show matching brackets
set nofoldenable                                    " Don't fold on opening file
set foldlevelstart=1                                " Initial folding level (setting this on ftplugin didn't work)
set cursorline                                      " Highlight current line
set list listchars=tab:→\ ,trail:·                  " Show tabs and trailing spaces
set fillchars=vert:┃                                " Solid line for vertical split

" Line wrap
set linebreak                                       " More inteligent wrapping (don't break words)
let &showbreak='⤷ '                                 " Use an arrow starting wrapped line
set breakindent                                     " Indent wrapped lines to match start
set breakindentopt=shift:2                          " Emphasize broken lines by indenting them

" Enable syntax highlighting on systemd files
autocmd BufRead,BufNewFile *.service*,*.timer* set ft=systemd


" BEHAVIOUR {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set modeline                                        " Enable modeline
set hidden                                          " Allow buffers to be hidden without saving
set mouse=a                                         " Enable the use of the mouse
set clipboard=unnamedplus                           " Use system clipboard

" Wait for typing to be completed (for slow typing on Termux)
set notimeout

" Fixes for st
if &term =~ '^st\($\|-\)'
  " Mouse wheel
  set ttymouse=sgr

  " Ctrl+arrow
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

" Remove comment leader when joining comment lines
set formatoptions+=j

" Search
set ignorecase                                      " Do case insensitive matching
set smartcase                                       " Do smart case matching
set incsearch                                       " Incremental search

" Command completion
set history=500                                     " Number of command lines remembered
set wildmenu
set wildmode=longest:full,full                      " First tab to complete longest *common* string
set wildignorecase

" Completion menu
set completeopt=longest,menu                        " Don't select first item, but longest common

" Put swap files in one directory. Fallback to working dir.
silent !mkdir -p ~/.vim/tmp/swap
set directory=$HOME/.vim/tmp/swap//,.

" Move ~/.viminfo to ~/.vim
silent !mkdir -p ~/.vim/tmp
set viminfo+='2000,n~/.vim/tmp/viminfo

augroup behaviour
  autocmd!

  " Open quickfix automatically (for shellcheck)
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost l* nested lwindow

  " Filter temporary git files from :oldfiles and :History
  autocmd BufEnter * call filter(v:oldfiles, 'v:val !~ "COMMIT_EDITMSG"')
  autocmd BufEnter * call filter(v:oldfiles, 'v:val !~ "rebase-merge"')

  " Run these commands whenever these files are updated
  autocmd BufWritePost compton.conf silent !killall compton && compton --daemon
  autocmd BufWritePost dwmbar silent !dwmbar
  autocmd BufWritePost dunstrc silent !killall dunst && dunst & disown
  autocmd BufWritePost $JUMPS silent !gen-jumps
  autocmd BufWritePost sxhkdrc silent !killall -USR1 sxhkd
  autocmd BufWritePost Xresources silent !xrdb $XRESOURCES
  autocmd BufWritePost Xresources silent !gen-dunst-theme
  autocmd BufWritePost xsettingsd.conf silent !killall -HUP xsettingsd

  " Set executable bit to scripts on bin
  autocmd BufWritePost * if getline(1) =~ '^#!\(/usr\)\?/bin/' && expand('%:p:h') =~ '/bin$' | silent !chmod +x <afile>
  autocmd BufWritePost * endif " Workaround, putting this in above line would prevent next autocmds to run

  " Set undo point after very sentence on prose files
  autocmd Filetype gitcommit,markdown,text inoremap . .<C-g>u
  autocmd Filetype gitcommit,markdown,text inoremap ! !<C-g>u
  autocmd Filetype gitcommit,markdown,text inoremap ? ?<C-g>u
  autocmd Filetype gitcommit,markdown,text inoremap : :<C-g>u
augroup END


" CODE STYLE AND SPELLING {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load indentation rules and plugin according to the detected filetype
filetype plugin indent on

" Default indentation
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Set default languages
set spelllang=pt_br,en_us,es_es

augroup spellcheck
  autocmd!

  " Turn on for file types, except on vimdiff
  autocmd Filetype gitcommit,markdown,text if ! &diff | setlocal spell | endif

  " Set languages for specific files
  autocmd Filetype gitcommit setlocal spelllang=en_us
  autocmd BufRead,BufNewFile */Code/* setlocal spelllang=en_us
augroup END

"}}}

