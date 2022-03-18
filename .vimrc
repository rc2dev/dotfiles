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
Plug 'freitass/todo.txt-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
if $SLOW_HOST != '1'
  Plug 'vim-airline/vim-airline'
  set noshowmode                                    " Don't show modes below status line (redundant to Airline)
endif
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
" reset the cursor on start
augroup myCmds
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
set cursorline                                      " Highlight current line
set list listchars=tab:→\ ,trail:·                  " Show tabs and trailing spaces
set fillchars=vert:┃                                " Solid line for vertical split

" Line wrap
set linebreak                                       " More inteligent wrapping (don't break words)
let &showbreak='⤷ '                                 " Use an arrow starting wrapped line
set breakindent                                     " Indent wrapped lines to match start
set breakindentopt=shift:2                          " Emphasize broken lines by indenting them


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

" Create tags file (this just runs ctags). This allows:
" ^] to jump to tag under cursor; g^] for ambiguous tags; ^t to jump back up the tag stack
command! MakeTags !ctags -R .

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
  autocmd BufWritePost dwmbar silent !dwmbar
  autocmd BufWritePost .xsettingsd silent !killall -HUP xsettingsd
  autocmd BufWritePost compton.conf silent !killall compton && compton --daemon
  autocmd BufWritePost dunstrc silent !killall dunst && dunst & disown
  autocmd BufWritePost $JUMPS silent !gen-jumps
  autocmd BufWritePost sxhkdrc silent !killall -USR1 sxhkd
  autocmd BufWritePost Xresources silent !xrdb $XRESOURCES

  " Set executable bit to scripts on bin
  autocmd BufWritePost * if getline(1) =~ '^#!\(/usr\)\?/bin/' && expand('%:p:h') =~ '/bin$' | silent !chmod +x <afile>
  autocmd BufWritePost * endif " Workaround, putting this in above line would prevent next autocmds to run

  " Set undo point after very sentence on prose files
  autocmd Filetype gitcommit,markdown,text inoremap . .<C-g>u
  autocmd Filetype gitcommit,markdown,text inoremap ! !<C-g>u
  autocmd Filetype gitcommit,markdown,text inoremap ? ?<C-g>u
  autocmd Filetype gitcommit,markdown,text inoremap : :<C-g>u
augroup END


" CODE STYLE {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load indentation rules and plugin according to the detected filetype
filetype plugin indent on

" Default indentation
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab


" SPELL CHECK {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


" PLUGINS CONFIGURATION {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline
" Show open buffers on top
let g:airline#extensions#tabline#enabled = 1
" Don't display spelling language
let g:airline_detect_spelllang = 0
" Use powerline symbols
let g:airline_powerline_fonts = 1
" Do not draw separators for empty sections
let g:airline_skip_empty_sections = 1
" Display a short path in statusline
let g:airline_stl_path_style = 'short'
" Skip display file format if it matches this string
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
" Don't display word count
let g:airline#extensions#wordcount#enabled = 0
" Redifine section z
let g:airline_section_z = '%#__accent_bold#%{g:airline_symbols.maxlinenr}%L%#__restore__# %p%%%{g:airline_symbols.linenr}%l,%v'


" vim-template
let g:templates_directory = ['$HOME/.vim/templates']
" Replace colon as Android 11 doesn't like them.
let g:templates_name_prefix = '.vim-template.'
let g:templates_no_builtin_templates = 1
let g:templates_user_variables = [
  \   ['FILE1', 'GetFileNoExt'],
  \ ]
" Only remove last extension
function! GetFileNoExt()
  return expand('%:t:r')
endfunction


" Goyo
" Ensure :q to quit when Goyo is active
" Toggle Limelight
function! s:GoyoEnter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd! QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!

  Limelight
endfunction

function! s:GoyoLeave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
      if b:quitting_bang
          qa!
      else
          qa
      endif
  endif

  Limelight!
endfunction

autocmd! User GoyoEnter call <SID>GoyoEnter()
autocmd! User GoyoLeave call <SID>GoyoLeave()

" Limelight
" The color for dimming down the surrounding paragraphs, as it can't calculate
" from the transparent theme
" Name or ANSI code (:help cterm-colors)
let g:limelight_conceal_ctermfg = 'DarkGray'
" Name or RGB color (:help gui-colors)
let g:limelight_conceal_guifg = '#777777'

" vim-markdown
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

" ranger.vim
" Open ranger when vim open a directory.
let g:ranger_replace_netrw = 1

" rooter
let g:rooter_silent_chdir = 1

" vim-localvimrc
let g:localvimrc_whitelist=resolve($NOTES . '/.lvimrc')
let g:localvimrc_blacklist='/'
" Disable sandbox as the only vimrc whitelists can't be run there,
" and we're always prompted.
let g:localvimrc_sandbox=0

" coc.nvim
" Use tab for trigger completion with characters ahead and navigate.
if has_key(g:plugs, 'coc.nvim')
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  "
  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  xmap <leader>r  <Plug>(coc-format-selected)
  nmap <leader>r  <Plug>(coc-format-selected)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  " Disable autocompletion for some file types
  autocmd FileType markdown,text let b:coc_suggest_disable = 1
endif


" KEYBINDINGS {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap leader keys (Space must be in double quotes)
let mapleader="\<Space>"
let maplocalleader=","

" For consistency with C and D
noremap Y y$

" Delete to black hole
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d
nnoremap <Leader>D "_D
nnoremap <Leader>x "_x
nnoremap <Leader>c "_c
vnoremap <Leader>c "_c
nnoremap <Leader>C "_C
nnoremap <Leader>x "_x

" Replace line or selection with default register content
nnoremap <Leader>p "_ddP
vnoremap <Leader>p "_dP

" Move selection up/down and re-format
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Toogle paste
set pastetoggle=<F2>

" Insert current date
inoremap <F3> <C-R>=strftime('%Y-%m-%d')<CR>

" Run current file (overwritten per filetype)
nnoremap <F5> :w<CR>:!%:p<CR>
inoremap <F5> <C-o>:w<CR><C-o>:!%:p<CR>

" Toggle spellcheck
nnoremap <F6> :setlocal spell!<CR>
inoremap <F6> <C-o>:setlocal spell!<CR>

" Save or quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap ZX :w\|:bd<CR>

" Avoid unintentional switch to Ex mode
nmap Q <nop>

" Edit files
nnoremap <Leader>ev :e ~/.vimrc<CR>

" Toggle folding with <Tab>
nnoremap <Tab> za

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
inoremap <C-Left>  <ESC>:echoe "Use b"<CR>
inoremap <C-Right> <ESC>:echoe "Use w"<CR>
inoremap <C-Up>    <ESC>:echoe "Use k"<CR>
inoremap <C-Down>  <ESC>:echoe "Use j"<CR>

" Use ctrl+jk on completion menu
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Use friendlier line navigation on prose files
augroup navigation
  autocmd!

  autocmd Filetype markdown,text,taskedit nnoremap <buffer> <expr> j v:count == 0 ? 'gj' : 'j'
  autocmd Filetype markdown,text,taskedit nnoremap <buffer> <expr> k v:count == 0 ? 'gk' : 'k'
  autocmd Filetype markdown,text,taskedit nnoremap <buffer> <Down> gj
  autocmd Filetype markdown,text,taskedit nnoremap <buffer> <Up> gk
  autocmd Filetype markdown,text,taskedit inoremap <buffer> <expr> <Down> pumvisible() ? "\<Down>" : "\<C-\>\<C-o>gj"
  autocmd Filetype markdown,text,taskedit inoremap <buffer> <expr> <Up> pumvisible() ? "\<Up>" : "\<C-\>\<C-o>gk"
augroup END

" Buffer navigation
nnoremap <Leader><Leader> <C-^>
nnoremap <Leader>n :bn<CR>
nnoremap <Leader>b :Buffers<CR>

" Navigate splits
nnoremap <silent> <c-k> :wincmd k<cr>
nnoremap <silent> <c-j> :wincmd j<cr>
nnoremap <silent> <c-h> :wincmd h<cr>
nnoremap <silent> <c-l> :wincmd l<cr>
tnoremap <silent> <expr> <c-k> &filetype == "fzf" ? "<c-k>" : "<c-w>k"
tnoremap <silent> <expr> <c-j> &filetype == "fzf" ? "<c-j>" : "<c-w>j"
tnoremap <silent> <expr> <c-h> &filetype == "fzf" ? "<c-h>" : "<c-w>h"
tnoremap <silent> <expr> <c-l> &filetype == "fzf" ? "<c-l>" : "<c-w>l"

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
nnoremap <Leader>gd :GDelete<CR>
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gm :GMove <C-R>=expand('%')<CR>
nnoremap <Leader>gl :Gclog<CR>
" NERDCommenter
" Disable default mappings and add mine
let g:NERDCreateDefaultMappings = 0
map <leader>; <plug>NERDCommenterToggle
" Termux
map <leader>/ <plug>NERDCommenterToggle
" thesaurus_query
" Disable keymappings and set my own
let g:tq_map_keys = 0
" <leader>ct is already used
nnoremap <Leader>cs :ThesaurusQueryReplaceCurrentWord<CR>
vnoremap <Leader>cs y:ThesaurusQueryReplace <C-r>"<CR>
" fzf.vim
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-g> :Files $HOME<CR>
nnoremap <silent> <C-f> :Rg<CR>
nnoremap <silent> <C-t> :History<CR>
" Goyo
nnoremap <F12> :Goyo<CR>
inoremap <F12> <C-o>:Goyo<CR>
" loupe
let g:LoupeClearHighlightMap=1
nmap <leader>m <Plug>(LoupeClearHighlight)


" ABBREVIATIONS {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab rca [RC added]
iab rcm [RC modified]
iab rcp Copyright (C) <C-r>=strftime('%Y')<CR> Rafael Cavalcanti <https://rafaelc.org/dev><CR>Licensed under GPLv3<CR>
iab rct Author: Rafael Cavalcanti <https://rafaelc.org/dev>
cabbr <expr> %% expand('%:p:h')

"}}}


" Source a global configuration file if available
if filereadable('/etc/vim/vimrc.local')
  source /etc/vim/vimrc.local
endif

