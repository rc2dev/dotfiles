" Options
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Misc options
set modeline                        " Enable modeline
set hidden                          " Allow buffers to be hidden without saving
set mouse=a                         " Enable the use of the mouse
set clipboard=unnamedplus           " Use system clipboard
set notimeout                       " Wait to complete typing (slow typing on Termux)
set formatoptions+=j                " Remove comment leader when joining comment lines
set shada=!,'500,<50,s10,h          " nvim: Increase oldfiles size

" Search
set ignorecase                      " Do case insensitive matching
set smartcase                       " Do smart case matching
set incsearch                       " Incremental search

" Command completion
set history=500                     " Number of command lines remembered
set wildmenu
set wildmode=longest:full,full      " First tab to complete longest *common* string
set wildignorecase

" Completion menu
set completeopt=longest,menu        " Don't select first item, but longest common

" Interface
set noshowmode                      " Don't show modes below status line (redundant to vim-airline)
set showcmd                         " Show partial command
set laststatus=2                    " Always show status line
set splitbelow splitright           " Splitting puts new window right of / below current
set fillchars=vert:┃                " Solid line for vertical split

" Editor appearance
syntax on                           " Enable syntax highlighting
set number
set relativenumber
set scrolloff=10                    " Minimum lines below cursor
set showmatch                       " Show matching brackets
set nofoldenable                    " Don't fold on opening file
set foldlevelstart=1                " Initial folding level (setting this on ftplugin didn't work)
set cursorline                      " Highlight current line
set list listchars=tab:→\ ,trail:·  " Show tabs and trailing spaces

" Line wrap
set linebreak                       " More inteligent wrapping (don't break words)
let &showbreak='⤷ '                 " Use an arrow starting wrapped line
set breakindent                     " Indent wrapped lines to match start
set breakindentopt=shift:2          " Emphasize broken lines by indenting them

" Default indentation
filetype plugin indent on           " Load indentation rules and plugin according to filetype
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

