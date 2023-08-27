" Colors config
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Uncomment this for transparency
" Only apply on dark themes. Don't do it on gvim as it will get messed up.
autocmd ColorScheme * if ! has('gui_running') && &bg == "dark" | hi Normal guibg=NONE ctermbg=NONE | endif

" Use truecolors
set termguicolors

" themes: Enable italics (must precede theme setting)
let g:onedark_terminal_italics=1
let g:gruvbox_italic=1

" We won't have the theme on first run
try
  colorscheme gruvbox
catch /^Vim\%((\a\+)\)\=:E185/
endtry
set bg=dark
