" Toggle spell check choosing languages.
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

function! ToggleSpell()
  if ! &spell
    let current_lang= &spelllang
    let new_lang = input("Language for spell check: ", current_lang)
    " Ideally it should be setlocal, but it's not being picked by &spelllang.
    exec ":set spelllang=" . new_lang
  endif

  setlocal spell!
  echo "\r"
  echo "Spell check toggled."
endfunction

