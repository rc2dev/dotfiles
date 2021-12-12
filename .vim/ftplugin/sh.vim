" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Suggested by :help write-filetype-plugin
if exists('b:did_ftplugin')
    finish
  endif
let b:did_ftplugin = 1

" Run vim-template even if no extension
if ! filereadable(expand('%'))
  execute 'Template *.sh'
endif
