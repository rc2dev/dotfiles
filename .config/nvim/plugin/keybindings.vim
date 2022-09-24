" Keybindings config
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Remap leader keys (Space must be in double quotes)
let mapleader="\<Space>"
let maplocalleader=","

" For consistency with C and D
noremap Y y$

" Toogle paste
set pastetoggle=<F2>

" Insert current date
inoremap <F3> <C-R>=strftime('%Y-%m-%d')<CR>

" Run current file (overwritten per filetype)
nnoremap <F5> :w<CR>:!%:p<CR>
inoremap <F5> <C-o>:w<CR><C-o>:!%:p<CR>

" Run make
nnoremap <F6> :w<CR>:make<CR>
inoremap <F6> <C-o>:w<CR><C-o>:make<CR>

" Toggle spellcheck
nnoremap <F7> :setlocal spell!<CR>
inoremap <F7> <C-o>:setlocal spell!<CR>

" Save or quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" Avoid unintentional switch to Ex mode
nmap Q <nop>

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

" Use ctrl+j/k, Tab on completion menu
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" Delete current file
nnoremap <Leader><Del> :call DeleteFile()<CR>
function! DeleteFile()
  if confirm("Delete file?", "&Yes\n&No", 2) != 1
    return
  endif

  call delete(expand('%'))
  bdelete!
endfunction

" Buffer navigation
nnoremap <Leader><Leader> <C-^>
nnoremap <Leader>b :Buffers<CR>
nnoremap ]b :bnext<CR>
nnoremap [b :bprevious<CR>

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
nnoremap <silent> <leader>ff :Rg<CR>
nnoremap <silent> <leader>fg :GFiles<CR>
nnoremap <silent> <leader>fh :History<CR>
nnoremap <silent> <leader>fp :Files<CR>

" loupe
" Use this instead of <leader>n.
nmap <leader>m <Plug>(LoupeClearHighlight)

" ranger.vim
nnoremap <leader>fr :Ranger<CR>

