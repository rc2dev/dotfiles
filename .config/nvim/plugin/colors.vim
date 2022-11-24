" Colors config
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Transparency
" Only apply on dark themes. Don't do it on gvim as it will get messed up.
autocmd ColorScheme * if ! has('gui_running') && &bg == "dark" | hi Normal guibg=NONE ctermbg=NONE | endif

" Use truecolors
set termguicolors
set bg=dark

" onedark theme: Enable italics (must precede theme setting)
let g:onedark_terminal_italics=1

" We won't have the theme on first run
try
  colorscheme onedark
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme desert
endtry
