" vim-template config
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

let g:templates_directory = ['$HOME/.config/nvim/templates']

" Replace colon as Android 11 doesn't like them.
let g:templates_name_prefix = '.vim-template_'

let g:templates_no_builtin_templates = 1

let g:templates_user_variables = [
  \   ['FILE1', 'GetFileNoExt'],
  \   ['FDATE1', 'GetFullDate'],
  \ ]

" Only remove last extension
function! GetFileNoExt()
  return expand('%:t:r')
endfunction

function! GetFullDate()
  return strftime('%Y-%m-%d %T %z')
endfunction
