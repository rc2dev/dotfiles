" Delete current file
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>
"
function! DelCurrentFile()
  if expand("%") == ""
    echo "File is not saved."
    return
  endif

  if confirm("Delete file?", "&Yes\n&No", 2) != 1
    return
  endif

  call delete(expand('%'))
  bdelete!
endfunction

