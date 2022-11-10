" Colors config
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Don't do it on gvim or it will get messed up
autocmd ColorScheme * if ! has('gui_running') | hi Normal guibg=NONE ctermbg=NONE | endif

" Use truecolors
set termguicolors
set bg=dark

" Enable italics in one dark theme
" (must precede theme setting)
let g:onedark_terminal_italics=1

" We won't have the theme on first run
try
  colorscheme onedark
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme desert
endtry
