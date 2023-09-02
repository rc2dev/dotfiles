" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

function! Journal(date)
  let l:dir_cmd="date -d " . a:date . " +'%Y-%m'"
  let l:dir=expand("$NOTES/notes/Journal/" . trim(system(l:dir_cmd)))
  call mkdir(l:dir, "p")

  let l:file_cmd="date -d " . a:date . " +'%Y-%m-%d %a' "
  let l:file=l:dir . "/" . trim(system(l:file_cmd)) . ".md"

  execute "edit " . l:file
endfunction
