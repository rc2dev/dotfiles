" Mappings
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Toggle paste. Still useful in tmux.
nnoremap <F2> :set paste!<CR>
inoremap <F2> <C-o>:set paste!<CR>

" Insert current date
inoremap <F3> <C-R>=strftime('%Y-%m-%d')<CR>

" Toggle spellcheck
nnoremap <F7> :call ToggleSpell()<CR>
inoremap <F7> <C-o>:call ToggleSpell()<CR>

" Toggle terminal on/off (neovim)
nnoremap <F9> :call TermToggle(12)<CR>
inoremap <F9> <Esc>:call TermToggle(12)<CR>
tnoremap <F9> <C-\><C-n>:call TermToggle(12)<CR>

" For consistency with C and D
noremap Y y$

" Avoid unintentional switch to Ex mode
nmap Q <nop>

" Clear search highlight
nnoremap <leader>hn :nohlsearch<CR>

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
nnoremap <Left>    :echoe "Use h"<CR>
nnoremap <Right>   :echoe "Use l"<CR>
nnoremap <Up>      :echoe "Use k"<CR>
nnoremap <Down>    :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>    <ESC>:echoe "Use h"<CR>
inoremap <Right>   <ESC>:echoe "Use l"<CR>
inoremap <Up>      <ESC>:echoe "Use k"<CR>
inoremap <Down>    <ESC>:echoe "Use j"<CR>
inoremap <C-Left>  <ESC>:echoe "Use b"<CR>
inoremap <C-Right> <ESC>:echoe "Use w"<CR>
inoremap <C-Up>    <ESC>:echoe "Use k"<CR>
inoremap <C-Down>  <ESC>:echoe "Use j"<CR>

nnoremap <Leader><Del> :call DelCurrentFile()<CR>

" Buffer navigation
nnoremap <Leader><Leader> <C-^>
nnoremap ]b :bnext<cr>
nnoremap [b :bprevious<cr>

" Toggle fold
nnoremap <Tab> za

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

" Toggle colorscheme
nnoremap <expr> <leader>cd &bg == "dark" ? ":set bg=light<CR>" : ":set bg=dark<CR>"


" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" lazy.nvim
nnoremap <leader>l :Lazy<CR>

" lazygit
nnoremap <Leader>gg :LazyGit<CR>

" NERDCommenter
map <leader>cc <plug>NERDCommenterToggle

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fF <cmd>Telescope find_files prompt_title=Find\ Files\ in\ buffer\ directory cwd=%:p:h <CR>
nnoremap <leader>fy <cmd>Telescope find_files prompt_title=Dotfiles cwd=$HOME find_command=dotfiles,ls-files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fG <cmd>Telescope live_grep prompt_title=Live\ Grep\ buffer\ directory search_dirs=%:p:h<CR>
nnoremap <leader>fh <cmd>Telescope oldfiles<CR>
nnoremap <leader>st <cmd>Telescope filetypes<CR>
nnoremap <leader>bb <cmd>Telescope buffers<CR>
nnoremap <leader>cs <cmd>Telescope colorscheme<CR>
nnoremap <leader>rr <cmd>Telescope registers<CR>
nnoremap <leader>hh <cmd>Telescope help_tags<CR>

" lf.vim
nnoremap <leader>fr :Lf<CR>

" vim-template
nnoremap <leader>te :Template<CR>

" zen-mode
nnoremap <F10> :ZenMode<CR>
inoremap <F10> <C-o>:ZenMode<CR>
