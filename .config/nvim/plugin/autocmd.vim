" Autocommands
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

augroup rc2dev
  autocmd!

  " Resize splits automatically if VIM is resized
  autocmd VimResized * execute "normal! \<C-w>="

  " nvim: Start terminal on insert mode
  autocmd TermOpen * startinsert

  " Filter temporary git files from :oldfiles and :History
  autocmd BufEnter * call filter(v:oldfiles, 'v:val !~ "COMMIT_EDITMSG"')
  autocmd BufEnter * call filter(v:oldfiles, 'v:val !~ "rebase-merge"')

  " Run these commands whenever these files are updated
  autocmd BufWritePost compton.conf silent !killall compton && compton --daemon
  autocmd BufWritePost dwmbar silent !dwmbar
  autocmd BufWritePost dunstrc silent !killall dunst && dunst & disown
  autocmd BufWritePost $JUMPS silent !gen-jumps
  autocmd BufWritePost sxhkdrc silent !killall -USR1 sxhkd
  autocmd BufWritePost $XRESOURCES silent !xrdb %
  autocmd BufWritePost $XRESOURCES silent !gen-dunst-theme
  autocmd BufWritePost xsettingsd.conf silent !killall -HUP xsettingsd

  " Set executable bit to scripts on bin
  autocmd BufWritePost * if getline(1) =~ '^#!\(/usr\)\?/bin/' && expand('%:p:h') =~ '/bin$' | silent !chmod +x <afile>
  autocmd BufWritePost * endif " Workaround, putting this in above line would prevent next autocmds to run

  " Set specific spell check languages for some files
  autocmd BufRead,BufNewFile */Code/* setlocal spelllang=en_us
augroup END

