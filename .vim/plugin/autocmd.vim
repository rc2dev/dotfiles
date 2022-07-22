" Autocommands
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

augroup rc2dev
  autocmd!

  " Resize splits automatically if VIM is resized
  autocmd VimResized * execute "normal! \<C-w>="

  " Filter temporary git files from :oldfiles and :History
  autocmd BufEnter * call filter(v:oldfiles, 'v:val !~ "COMMIT_EDITMSG"')
  autocmd BufEnter * call filter(v:oldfiles, 'v:val !~ "rebase-merge"')

  " Run these commands whenever these files are updated
  autocmd BufWritePost compton.conf silent !killall compton && compton --daemon
  autocmd BufWritePost dwmbar silent !dwmbar
  autocmd BufWritePost dunstrc silent !killall dunst && dunst & disown
  autocmd BufWritePost $JUMPS silent !gen-jumps
  autocmd BufWritePost sxhkdrc silent !killall -USR1 sxhkd
  autocmd BufWritePost Xresources silent !xrdb $XRESOURCES
  autocmd BufWritePost Xresources silent !gen-dunst-theme
  autocmd BufWritePost xsettingsd.conf silent !killall -HUP xsettingsd

  " Set executable bit to scripts on bin
  autocmd BufWritePost * if getline(1) =~ '^#!\(/usr\)\?/bin/' && expand('%:p:h') =~ '/bin$' | silent !chmod +x <afile>
  autocmd BufWritePost * endif " Workaround, putting this in above line would prevent next autocmds to run

  " Set undo point after very sentence on prose files
  autocmd Filetype gitcommit,markdown,text inoremap . .<C-g>u
  autocmd Filetype gitcommit,markdown,text inoremap ! !<C-g>u
  autocmd Filetype gitcommit,markdown,text inoremap ? ?<C-g>u
  autocmd Filetype gitcommit,markdown,text inoremap : :<C-g>u

  " Turn spell check on for some file types, except on vimdiff
  autocmd Filetype gitcommit,markdown,text if ! &diff | setlocal spell | endif

  " Set specific spell check languages for some files
  autocmd Filetype gitcommit setlocal spelllang=en_us
  autocmd BufRead,BufNewFile */Code/* setlocal spelllang=en_us
augroup END
