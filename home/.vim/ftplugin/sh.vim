" Author: Rafael Cavalcanti

" Run shellcheck on save
setlocal makeprg=shellcheck\ -f\ gcc\ %
autocmd BufWritePost * :silent make | redraw!
