" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Suggested by :help write-filetype-plugin
if exists('b:did_ftplugin')
    finish
  endif
let b:did_ftplugin = 1

" Turn spell check on, except on vimdiff
setlocal spell
setlocal spelllang=en_us

" Prevent commit messages starting with 'vim:' from triggering modeline
setlocal nomodeline
