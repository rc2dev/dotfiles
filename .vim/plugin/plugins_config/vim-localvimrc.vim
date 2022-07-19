" vim-localvimrc config
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

let g:localvimrc_whitelist=resolve($NOTES . '/.lvimrc')
let g:localvimrc_blacklist='/'

" Disable sandbox as the only vimrc whitelists can't be run there,
" and we're always prompted.
let g:localvimrc_sandbox=0
