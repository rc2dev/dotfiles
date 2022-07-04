" Goyo and Limelight config
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Ensure :q to quit when Goyo is active
" Toggle Limelight
function! s:GoyoEnter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd! QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!

  Limelight
endfunction

function! s:GoyoLeave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
      if b:quitting_bang
          qa!
      else
          qa
      endif
  endif

  Limelight!
endfunction

autocmd! User GoyoEnter call <SID>GoyoEnter()
autocmd! User GoyoLeave call <SID>GoyoLeave()

" The color for dimming down the surrounding paragraphs, as it can't calculate
" from the transparent theme
" Name or ANSI code (:help cterm-colors)
let g:limelight_conceal_ctermfg = 'DarkGray'
" Name or RGB color (:help gui-colors)
let g:limelight_conceal_guifg = '#777777'

