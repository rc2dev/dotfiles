" Additional custom syntax for markdown.
" Highlight TODO, DONE keywords on markdown files.
" Based on <https://github.com/preservim/vim-markdown/issues/507#issuecomment-683455262>.
"
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

syntax case match

syn match mkdTodo /TODO:\?/ containedin=htmlH[2-6],mkdNonListItemBlock,mkdListItemLine
hi def link mkdTodo  Todo

syn match mkdDone /DONE:\?/ containedin=htmlH[2-6],mkdNonListItemBlock,mkdListItemLine
hi def link mkdDone  Comment

syntax case ignore
