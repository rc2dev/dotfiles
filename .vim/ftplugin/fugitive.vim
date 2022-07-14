" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

if &modifiable
  finish
endif

nnoremap <buffer> pp :Git push<CR>
nnoremap <buffer> pf :Git push --force-with-lease<CR>
nnoremap <buffer> p<space> :Git push<space>
