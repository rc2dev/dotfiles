" rooter config
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

" Define custom GFiles that deals with accentuated files
" (<https://github.com/junegunn/fzf.vim/pull/500>)
command! -bang GFiles2 call fzf#run(fzf#wrap({'options': '--read0', 'source': 'git ls-files -z'}, <bang>0))
