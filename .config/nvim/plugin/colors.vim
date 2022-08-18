" Colors config
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Don't do it on gvim or it will get messed up
autocmd ColorScheme * if ! has('gui_running') | hi Normal guibg=NONE ctermbg=NONE | endif

" Use truecolors
set termguicolors
set bg=dark

" We won't have the theme on first run
try
  colorscheme dracula
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme desert
endtry

