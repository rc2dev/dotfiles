" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

function! s:SetTransparency()
  " Don't do it on gvim or it will get messed up
  if has('gui_running')
    return
  endif

  let l:theme_guibg = synIDattr(hlID('Normal'), 'bg')
  hi Normal guibg=NONE ctermbg=NONE
  " Fix :terminal having black background after the above command.
  execute 'hi Terminal guibg=' . l:theme_guibg
endfunction

augroup appearance
  autocmd!

  autocmd ColorScheme * call <SID>SetTransparency()

 " For dracula theme, make tab chars more subtle
 autocmd ColorScheme dracula hi! link SpecialKey DraculaComment

  " Resize splits automatically if VIM is resized
  autocmd VimResized * execute "normal! \<C-w>="
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

" Fix colors on st
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
