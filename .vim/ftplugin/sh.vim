" Author: Rafael Cavalcanti

" Run shellcheck on save
if executable('shellcheck')
  setlocal makeprg=shellcheck\ -f\ gcc\ %
  autocmd BufWritePost * :silent make | redraw!
endif
