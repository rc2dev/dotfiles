" Keybindings config
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Toggle paste. Still useful in tmux.
set pastetoggle=<F2>

" Insert current date
inoremap <F3> <C-R>=strftime('%Y-%m-%d')<CR>

" Toggle spellcheck
nnoremap <F7> :setlocal spell!<CR>
inoremap <F7> <C-o>:setlocal spell!<CR>

" Toggle terminal on/off (neovim)
nnoremap <F12> :call TermToggle(12)<CR>
inoremap <F12> <Esc>:call TermToggle(12)<CR>
tnoremap <F12> <C-\><C-n>:call TermToggle(12)<CR>

" Open terminal in new window
" This is useful because it opens in the current directory.
nnoremap <F24> :silent !$TERMINAL & disown<CR>
inoremap <F24> <Esc>:silent !$TERMINAL & disown<CR>
tnoremap <F24> <C-\><C-n>:silent !$TERMINAL & disown<CR>

" For consistency with C and D
noremap Y y$

" Avoid unintentional switch to Ex mode
nmap Q <nop>

" Toggle folding with <Tab>
nnoremap <Tab> za

" Repeat last macro with return
" Check if modifiable, as fugitive buffer uses <cr>
nnoremap <expr> <cr> (&modifiable == 1) ? "@@" : "<cr>"

" New buffer
nnoremap <Leader>e :enew<CR>

" Save or quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <expr> q (&modifiable == 1) ? "q" : ":q<CR>"

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

" Delete current file
nnoremap <Leader><Del> :call DeleteFile()<CR>
function! DeleteFile()
  if expand("%") == ""
    echo "File is not saved."
    return
  endif

  if confirm("Delete file?", "&Yes\n&No", 2) != 1
    return
  endif

  call delete(expand('%'))
  bdelete!
endfunction

" Buffer navigation
nnoremap <Leader><Leader> <C-^>
nnoremap ]b :bnext<CR>
nnoremap [b :bprevious<CR>

" Navigate splits and completion menus with C-jk
" Most of this is probably redundant to vim-tmux-navigator, but works well
" with or without the plugin.
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
inoremap <silent> <c-h> <Esc><c-h>
inoremap <silent> <c-l> <Esc><c-l>
inoremap <silent> <expr> <c-k> pumvisible() ? "<c-p>" : "<Esc><c-k>"
inoremap <silent> <expr> <c-j> pumvisible() ? "<c-n>" : "<Esc><c-j>"
cnoremap <expr> <C-j> pumvisible() ? "<C-n>" : "<C-j>"
cnoremap <expr> <C-k> pumvisible() ? "<C-p>" : "<C-k>"
tnoremap <silent> <c-k> <c-\><c-n>TmuxNavigateUp<cr>
tnoremap <silent> <c-j> <c-\><c-n>:TmuxNavigateDown<cr>
tnoremap <silent> <c-h> <c-\><c-n>:TmuxNavigateLeft<cr>
tnoremap <silent> <c-l> <c-\><c-n>:TmuxNavigateRight<cr>

" Cycle completion with Tab
inoremap <expr> <Tab> pumvisible() ? "<C-n>" : "<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "<C-p>" : "<S-Tab>"

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

" nvim: Easier escape on terminal mode
tnoremap <C-\><C-\> <C-\><C-n>


" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" lazy.nvim
nnoremap <leader>l :Lazy<CR>

" alpha.nvim
nnoremap <leader>a :Alpha<CR>

" vim-fugitive
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gm :GMove <C-R>=expand('%')<CR>
nnoremap <Leader>gl :Gclog<CR>
nnoremap <Leader>ys :Dotfiles<CR>
nnoremap <Leader>ya :Dotfiles add %<CR>

" NERDCommenter
" Disable default mappings and add mine
let g:NERDCreateDefaultMappings = 0
map <leader>/ <plug>NERDCommenterToggle

" Find files using Telescope
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fF <cmd>Telescope find_files cwd=%:p:h prompt_title=Find\ Files\ in\ buffer\ directory<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fG <cmd>Telescope live_grep search_dirs=%:p:h prompt_title=Live\ Grep\ buffer\ directory<CR>
nnoremap <leader>fp <cmd>Telescope projects<CR>
nnoremap <leader>bg <cmd>Telescope live_grep grep_open_files=true prompt_title=Live\ Grep\ open\ buffers<CR>
nnoremap <leader>bb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope oldfiles<CR>
nnoremap <leader>fn <cmd>TeNotes<CR>
nnoremap <leader>fc <cmd>TeCode<CR>
nnoremap <leader>fy <cmd>TeDotfiles<CR>
nnoremap <Leader>fe :e <C-r>=fnameescape(expand('%:p:h'))<cr>/
nnoremap <leader>? <cmd>Telescope help_tags<CR>
nnoremap <leader>cc <cmd>Telescope colorscheme<CR>
nnoremap <expr> <leader>cd &bg == "dark" ? ":set bg=light<CR>" : ":set bg=dark<CR>"

" Journal
command! -nargs=0 Journal :execute ":edit $NOTES/notes/Journal/" . strftime('%Y-%m/%Y-%m-%d %a') . ".md"
command! -nargs=0 JournalYesterday :execute ":edit $NOTES/notes/Journal/" . trim(system("date -d yesterday +'%Y-%m/%Y-%m-%d %a'")) . ".md"
nnoremap <leader>fj :Journal<cr>
nnoremap <leader>fJ :JournalYesterday<cr>

" lf.vim
nnoremap <leader>fr :Lf<CR>

" nvimtree
" Also close goyo if open.
nnoremap <leader>ft :Goyo!<CR>:NvimTreeFindFile<CR>
nnoremap <leader>fT :Goyo!<CR>:NvimTreeToggle<CR>

" goyo.vim
nnoremap <F11> :Goyo<CR>
inoremap <F11> <C-o>:Goyo<CR>

" vim-template
nnoremap <leader>te :Template<CR>
