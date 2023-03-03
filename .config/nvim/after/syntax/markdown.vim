" Additional custom syntax for markdown.
" Highlight TODO, DONE keywords on markdown files.
" Based on <https://github.com/preservim/vim-markdown/issues/507#issuecomment-683455262>.
"
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

syntax case match

syn match mkdBrackets /\v\[.{-}\]($|\s|:)/ containedin=htmlH[1-6],mkdNonListItemBlock,mkdListItemLine
hi def link mkdBrackets  Label

syn match mkdTodo /\v<TODO>:?/ containedin=htmlH[2-6],mkdNonListItemBlock,mkdListItemLine
hi def link mkdTodo  Todo

syn match mkdDone /\v\[?<DONE>:?(.{-}\])?/ containedin=htmlH[2-6],mkdNonListItemBlock,mkdListItemLine
hi def link mkdDone  Comment

" Use this set of characters instead of \w so we match accentuated
" characters.
syn match mkdTags /\v(^|\s)\@[A-zÀ-ú]+/ containedin=htmlH[1-6],mkdNonListItemBlock,mkdListItemLine
hi def link mkdTags  Label

syntax case ignore
