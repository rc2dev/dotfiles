" Trim whitespace when saving
" Author: Rafael Cavalcanti - rafaelc.org

function! s:Trim()
    if !&binary && &filetype != 'diff'
        :%s/\s\+$//e                                " Remove trailing whitespace in every line
        :%s/^\n\+\%$//e                             " Remove blank lines at the end of the file
    endif
endfunction
autocmd BufWrite * if g:autotrim | call <SID>Trim() | endif

let g:autotrim = 1
function s:AutoTrimToggle()
    if g:autotrim
        let g:autotrim = 0
        echo 'Autotrim disabled.'
    else
        let g:autotrim = 1
        echo 'Autotrim enabled.'
    endif
endfunction
command AutoTrimToggle :call <SID>AutoTrimToggle()
