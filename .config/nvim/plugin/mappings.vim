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

nnoremap <Leader><Del> :call DelCurrentFile()<CR>

" Buffer navigation
nnoremap <Leader><Leader> <C-^>
nnoremap ]b :bnext<cr>
nnoremap [b :bprevious<cr>

" Toggle fold
nnoremap <Tab> za

" Navigate splits with C-jk
" Most of this is probably redundant to vim-tmux-navigator, but works well
" with or without the plugin.
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
inoremap <silent> <c-h> <Esc><c-h>
inoremap <silent> <c-l> <Esc><c-l>
tnoremap <silent> <c-k> <c-\><c-n>TmuxNavigateUp<cr>
tnoremap <silent> <c-j> <c-\><c-n>:TmuxNavigateDown<cr>
tnoremap <silent> <c-h> <c-\><c-n>:TmuxNavigateLeft<cr>
tnoremap <silent> <c-l> <c-\><c-n>:TmuxNavigateRight<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Based on documentation from coc.nvim
" (<https://github.com/neoclide/coc.nvim#example-vim-configuration>)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>fc <Plug>(coc-format-selected)
nmap <leader>fc <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)
" Create command for Prettier
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
