" Trash or delete current file
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

function! TrashFile()
  if expand("%") == ""
    echo "File is not saved."
    return
  endif

  let l:filename = expand('%:p')
  let l:use_trash = executable('trash')
  let l:question = l:use_trash ? "Move file to trash?" : "Permanently delete file?"

  if confirm(l:question, "&Yes\n&No", 2) != 1
    return
  endif

  if l:use_trash
    call system('trash ' . shellescape(l:filename))
  else
    call delete(l:filename)
  endif

  bdelete!
endfunction
