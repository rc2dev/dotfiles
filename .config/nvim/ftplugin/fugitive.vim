" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Suggested by :help write-filetype-plugin
if exists('b:did_ftplugin')
    finish
  endif
let b:did_ftplugin = 1

nnoremap <buffer> pp :Git push<CR>
nnoremap <buffer> pf :Git push --force-with-lease<CR>
nnoremap <buffer> p<space> :Git push<space>
