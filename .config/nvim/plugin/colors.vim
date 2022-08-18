" Colors config
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

function! s:SetTransparency()
  " Don't do it on gvim or it will get messed up
  if has('gui_running')
    return
  endif

  let l:theme_guibg = synIDattr(hlID('Normal'), 'bg')
  hi Normal guibg=NONE ctermbg=NONE
endfunction

augroup colorscheme
  autocmd!

  autocmd ColorScheme * call <SID>SetTransparency()

  " For dracula theme, make tab chars more subtle
  autocmd ColorScheme dracula hi! link SpecialKey DraculaComment
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

