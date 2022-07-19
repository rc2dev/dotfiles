" Keybindings config
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

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

" Delete current file
nnoremap <Leader><Del> :call delete(expand('%')) \| echo "Deleted file."<CR>

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
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-fugitive
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gm :GMove <C-R>=expand('%')<CR>
nnoremap <Leader>gl :Gclog<CR>

" NERDCommenter
" Disable default mappings and add mine
let g:NERDCreateDefaultMappings = 0
map <leader>/ <plug>NERDCommenterToggle

" fzf.vim
if $GIT_DIR == "" && $GIT_WORK_TREE == ""
  nnoremap <silent> <C-p> :Files<CR>
else
  " Useful for bare directories such as dotfiles
  nnoremap <silent> <C-p> :GFiles<CR>
endif
nnoremap <silent> <C-f> :Rg<CR>
nnoremap <silent> <C-t> :History<CR>

" loupe
" Use this instead of <leader>n.
nmap <leader>m <Plug>(LoupeClearHighlight)

