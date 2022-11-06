" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

function! DotfilesComplete(A, L, P) abort
  return fugitive#Complete(a:A, a:L, a:P, {'git_dir': expand("~/.local/share/dotfiles/repo.git")})
endfunction

command! -bang -nargs=? -range=-1 -complete=customlist,DotfilesComplete Dotfiles exe fugitive#Command(<line1>, <count>, +"<range>", <bang>0, "<mods>", <q-args>,  { 'git_dir': expand("~/.local/share/dotfiles/repo.git") })
