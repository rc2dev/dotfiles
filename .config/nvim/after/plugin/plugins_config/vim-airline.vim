" vim-airline config
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Show open buffers on top
let g:airline#extensions#tabline#enabled = 1

" Don't display spelling language
let g:airline_detect_spelllang = 0

" Don't use powerline symbols
let g:airline_powerline_fonts = 0

" Do not draw separators for empty sections
let g:airline_skip_empty_sections = 1

" Display a short path in statusline
let g:airline_stl_path_style = 'short'

" Skip display file format if it matches this string
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" Don't display word count
let g:airline#extensions#wordcount#enabled = 0

" Redifine section z
let g:airline_section_z = '%p%%%{g:airline_symbols.linenr}%l,%v %#__accent_bold#%{g:airline_symbols.maxlinenr} %L%#__restore__#'

