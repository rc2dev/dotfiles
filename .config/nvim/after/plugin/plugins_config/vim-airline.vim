" vim-airline config
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Don't display spelling language
let g:airline_detect_spelllang = 0

" Skip display file format if it matches this string
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" Don't display word count
let g:airline#extensions#wordcount#enabled = 0

" Redefine section z
let g:airline_section_z = '%p%%%{g:airline_symbols.linenr}%l,%v'

" Fix git branch symbol
let g:airline_symbols.branch = ''
