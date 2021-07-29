" ~/.vimrc
"
" Author: Rafael Cavalcanti - rafaelc.org
"

" Don't mimic Vi
set nocompatible


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug (needs single quotes)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'preservim/nerdcommenter'
Plug 'aperezdc/vim-template'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'tpope/vim-fugitive'
Plug 'ron89/thesaurus_query.vim'
Plug 'mattn/emmet-vim'
Plug 'vim-scripts/AutoComplPop'
Plug 'ap/vim-css-color'
Plug 'ferrine/md-img-paste.vim'
Plug 'plasticboy/vim-markdown'
Plug 'francoiscabrol/ranger.vim'
Plug 'airblade/vim-rooter'
Plug 'LucHermitte/lh-vim-lib'                       " Dependency for local_vimrc
Plug 'LucHermitte/local_vimrc'
Plug 'wincent/loupe'
Plug 'dense-analysis/ale'
if $SLOW_HOST != '1'
    Plug 'vim-airline/vim-airline'
    set noshowmode                                  " Don't show modes below status line (redundant to Airline)
endif
" Colorschemes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'arcticicestudio/nord-vim'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" APPEARANCE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme
set termguicolors                                   " Use truecolors
colorscheme nord

" Fix colors on st
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

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
set linebreak                                       " More inteligent wrapping (don't break words)
set scrolloff=10                                    " Minimum lines below cursor
set showmatch                                       " Show matching brackets
set nofoldenable                                    " Don't fold on opening file
set cursorline                                      " Highlight current line
" Show tabs and trailing spaces
set list listchars=tab:→\ ,trail:·

augroup appearance
    " Resize splits automatically if VIM is resized
    autocmd VimResized * execute "normal! \<C-w>="
augroup END

function! EnableTransparency()
    " Don't do it on gvim or it will get messed up
    if has('gui_running')
        return
    endif

    set bg=dark
    hi Normal guibg=NONE ctermbg=NONE
endfunction

function! DisableTransparency()
    set bg=dark
endfunction

call EnableTransparency()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEHAVIOUR
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set modeline                                        " Enable modeline
set hidden                                          " Allow buffers to be hidden without saving
set mouse=a                                         " Enable the use of the mouse
set clipboard=unnamedplus                           " Use system clipboard

" Fix mouse scrollwheel on st
if &term =~ '^st\($\|-\)'
  set ttymouse=sgr
endif

" Create tags file (this just runs ctags). This allows:
" ^] to jump to tag under cursor; g^] for ambiguous tags; ^t to jump back up the tag stack
command! MakeTags !ctags -R .

" Search
set ignorecase                                      " Do case insensitive matching
set smartcase                                       " Do smart case matching
set incsearch                                       " Incremental search

" Command completion
set history=500                                     " Number of command lines remembered
set wildmenu
set wildmode=longest:full,full                      " First tab to complete longest *common* string

" Completion menu
set completeopt=longest,menu                        " Don't select first item, but longest common

" Put swap files in one directory. Fallback to working dir.
silent !mkdir -p ~/.vim/swap
set directory=$HOME/.vim/swap//,.

" Move ~/.viminfo to ~/.vim
set viminfo+='1000,n~/.vim/viminfo

augroup behaviour
    " Open quickfix automatically (for shellcheck)
    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost l* nested lwindow

    " Filter temporary commit files from :oldfiles and :History
    autocmd BufEnter * call filter(v:oldfiles, 'v:val !~ "COMMIT_EDITMSG"')

    " Run these commands whenever these files are updated
    autocmd BufWritePost dwmbar silent !dwmbar
    autocmd BufWritePost .xsettingsd silent !killall -HUP xsettingsd
    autocmd BufWritePost compton.conf silent !killall compton && compton --daemon
    autocmd BufWritePost dunstrc silent !killall dunst && dunst & disown

    " Set executable bit to scripts
    autocmd BufWritePost * if getline(1) =~ '^#!\(/usr\)\?/bin/' | silent !chmod +x <afile>
    autocmd BufWritePost * endif " Workaround, putting this in above line would prevent next autocmds to run

    " Set undo point after very sentence on prose files
    autocmd Filetype gitcommit,markdown,text inoremap . .<C-g>u
    autocmd Filetype gitcommit,markdown,text inoremap ! !<C-g>u
    autocmd Filetype gitcommit,markdown,text inoremap ? ?<C-g>u
    autocmd Filetype gitcommit,markdown,text inoremap : :<C-g>u
augroup END



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
function! Trim()
    if !&binary && &filetype != 'diff'
        :%s/\s\+$//e                                " Remove trailing whitespace in every line
        :%s/^\n\+\%$//e                             " Remove blank lines at the end of the file
    endif
endfunction
autocmd BufWrite * if g:autotrim | call Trim() | endif

let g:autotrim = 1
function AutoTrimToggle()
    if g:autotrim
        let g:autotrim = 0
        echo 'Autotrim disabled.'
    else
        let g:autotrim = 1
        echo 'Autotrim enabled.'
    endif
endfunction
command AutoTrimToggle :call AutoTrimToggle()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SPELL CHECK
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set default languages
set spelllang=pt_br,en_us,es_es

" Turn on for file types, except on vimdiff
autocmd Filetype gitcommit,markdown,text if ! &diff | setlocal spell | endif

" Set languages for specific files
autocmd Filetype gitcommit setlocal spelllang=en_us
autocmd BufRead,BufNewFile */Code/* setlocal spelllang=en_us


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-closetag
" Enable for *.erb
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb'

" vim-airline
" Show open buffers on top
let g:airline#extensions#tabline#enabled = 1

" vim-template
let g:templates_directory = ['$HOME/.vim/templates']
" Replace colon as Android 11 doesn't like them.
let g:templates_name_prefix = '.vim-template.'
let g:templates_no_builtin_templates = 1
let g:templates_user_variables = [
		\   ['FFDATE', 'GetFullDate'],
                \   ['FILE1', 'GetFileNoExt'],
                \   ['DIR', 'GetDir'],
		\ ]
function! GetFullDate()
		return strftime('%Y-%m-%d %T %z')
endfunction
" Only remove last extension
function! GetFileNoExt()
    return expand('%:t:r')
endfunction
function! GetDir()
    return expand('%:p:h:t')
endfunction


" Goyo
" Ensure :q to quit when Goyo is active
" Toggle Limelight
" Restore transparency on leave
function! s:goyo_enter()
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!

    Limelight
endfunction

function! s:goyo_leave()
    " Quit Vim if this is the only remaining buffer
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
            qa!
        else
            qa
        endif
    endif

    Limelight!
    call EnableTransparency()
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" emmet-vim
let g:user_emmet_leader_key=','
let g:user_emmet_mode='n'

" md-img-paste
autocmd FileType markdown inoremap <buffer><silent> <C-b> <C-o>:call mdip#MarkdownClipboardImage()<CR>

" vim-markdown
let g:vim_markdown_folding_level = 2
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

" AutoComplPop
" For markdown and text: only complete files
if(exists('g:acp_behavior'))
    let g:acp_behavior.markdown=[{'meets': 'acp#meetsForFile', 'repeat': 1, 'command': ''}]
    let g:acp_behavior.text=[{'meets': 'acp#meetsForFile', 'repeat': 1, 'command': ''}]
else
    let g:acp_behavior={
                \ 'markdown': [{'meets': 'acp#meetsForFile', 'repeat': 1, 'command': ''}],
                \ 'text': [{'meets': 'acp#meetsForFile', 'repeat': 1, 'command': ''}]
                \ }
endif

" rooter
let g:rooter_silent_chdir = 1

" local_vimrc
" Add $NOTES to the whitelist
call lh#local_vimrc#munge('whitelist', resolve($NOTES).'/..')
" Remove $HOME from the asklist and add it to the blacklist
call lh#local_vimrc#filter_list('asklist', 'v:val != $HOME')
call lh#local_vimrc#munge('blacklist', $HOME)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEYBINDINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap leader key (Space must be in double quotes)
let mapleader="\<Space>"

" For consistency with C and D
noremap Y y$

" Delete to black hole
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d
nnoremap <Leader>D "_D
nnoremap <LeadeR>x "_x
nnoremap <Leader>c "_c
vnoremap <Leader>c "_c
nnoremap <Leader>C "_C
nnoremap <LeadeR>x "_x

" Replace line or selection with default register content
nnoremap <Leader>p "_ddP
vnoremap <Leader>p "_dP

" Insert current date
inoremap <F3> <C-R>=strftime('%Y-%m-%d')<CR>

" Run current file
nnoremap <F5> :w<CR>:!%:p<CR>
inoremap <F5> <C-o>:w<CR><C-o>:!%:p<CR>
autocmd FileType markdown nnoremap <F5> :MarkdownPreview<CR>
autocmd FileType markdown inoremap <F5> <C-o>:MarkdownPreview<CR>

" Toggle spellcheck
nnoremap <F6> :setlocal spell!<CR>
inoremap <F6> <C-o>:setlocal spell!<CR>

" Save or quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>z :x<CR>

" Avoid unintentional switch to Ex mode
nmap Q <nop>

" Edit files
nnoremap <Leader>ev :e ~/.vimrc<CR>

" Try to prevent using the arrow keys for movement.
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" Use ctrl+jk on completion menu
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Use friendlier line navigation on prose files
augroup navigation
    autocmd Filetype markdown,text,taskedit nnoremap <buffer> <expr> j v:count == 0 ? 'gj' : 'j'
    autocmd Filetype markdown,text,taskedit nnoremap <buffer> <expr> k v:count == 0 ? 'gk' : 'k'
    autocmd Filetype markdown,text,taskedit nnoremap <buffer> <Down> gj
    autocmd Filetype markdown,text,taskedit nnoremap <buffer> <Up> gk
    autocmd Filetype markdown,text,taskedit inoremap <buffer> <expr> <Down> pumvisible() ? "\<Down>" : "\<C-\>\<C-o>gj"
    autocmd Filetype markdown,text,taskedit inoremap <buffer> <expr> <Up> pumvisible() ? "\<Up>" : "\<C-\>\<C-o>gk"
augroup END

" Buffer navigation
nnoremap <Leader><Leader> <C-^>
nnoremap <Leader>j :bp<CR>
nnoremap <Leader>k :bn<CR>
nnoremap <Leader>b :Buffers<CR>

" Navigate splits
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

" Resize splits
nnoremap <silent> <C-Left> :vertical resize -3<CR>
nnoremap <silent> <C-Right> :vertical resize +3<CR>
nnoremap <silent> <C-Up> :resize +3<CR>
nnoremap <silent> <C-Down> :resize -3<CR>

" Change 2 splits from/to vertical/horizontal
nnoremap <Leader>th <C-w>t<C-w>K
nnoremap <Leader>tv <C-w>t<C-w>H

" Close all splits but the current one
nnoremap <Leader>o <C-w>o

" Save as root and source ~/.vimrc
cmap w!! w !sudo tee % > /dev/null
command Sv :so ~/.vimrc

" Plugins
" vim-fugitive
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gm :GMove <C-R>=expand('%')<CR>
nnoremap <Leader>gl :Gclog<CR>
" NERDCommenter
" Disable default mappings and add mine
let g:NERDCreateDefaultMappings = 0
map <leader>; <plug>NERDCommenterToggle
" thesaurus_query
" Disable keymappings and set my own
let g:tq_map_keys = 0
nnoremap <Leader>ct :ThesaurusQueryReplaceCurrentWord<CR>
vnoremap <Leader>ct y:ThesaurusQueryReplace <C-r>"<CR>
" fzf.vim
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-g> :Files $HOME<CR>
nnoremap <silent> <C-f> :Rg<CR>
nnoremap <silent> <C-t> :History<CR>
" Goyo
" Disabling transparency using GoyoEnter causes some borders to show.
" Disabling it here instead is a workaround.
nnoremap <F12> :call DisableTransparency()<CR>:Goyo<CR>
inoremap <F12> <C-o>:call DisableTransparency()<CR><C-o>:Goyo<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ABBREVIATIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab rca [RC added]
iab rcm [RC modified]
iab rcp Copyright (C) <C-r>=strftime('%Y')<CR> Rafael Cavalcanti - rafaelc.org<CR>Licensed under GPLv3<CR>
iab rct Author: Rafael Cavalcanti - rafaelc.org


" Source a global configuration file if available
if filereadable('/etc/vim/vimrc.local')
    source /etc/vim/vimrc.local
endif

