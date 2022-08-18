" Term config
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Use different cursor for insert/normal mode
" Adapted from <https://stackoverflow.com/a/42118416>
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
" Reset the cursor on start
augroup cursor
  au!
  autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

