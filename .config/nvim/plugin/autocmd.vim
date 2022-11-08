" Autocommands
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

augroup rc2dev
  autocmd!

  " Resize splits automatically if VIM is resized
  autocmd VimResized * execute "normal! \<C-w>="

  " nvim: Start terminal on insert mode
  autocmd TermOpen * startinsert

  " Filter temporary git files and term:// from :oldfiles and :History
  autocmd BufEnter * call filter(v:oldfiles, 'v:val !~ "COMMIT_EDITMSG"')
  autocmd BufEnter * call filter(v:oldfiles, 'v:val !~ "rebase-merge"')
  autocmd BufEnter * call filter(v:oldfiles, 'v:val !~ "term://"')

  " Run these commands whenever these files are updated
  autocmd BufWritePost bato.yaml silent !killall bato && bato & disown
  autocmd BufWritePost compton.conf silent !killall compton && compton --daemon
  autocmd BufWritePost dwmbar silent !dwmbar
  autocmd BufWritePost ~/.config/dunst/* silent !killall dunst && dunst & disown
  autocmd BufWritePost ~/.config/dunst/*,*Xresources silent !gen-dunst-theme
  autocmd BufWritePost ~/.config/jumps.conf silent !gen-jumps
  autocmd BufWritePost ~/.config/nvim/init.vim source % | PlugClean! | PlugInstall
  autocmd BufWritePost sxhkdrc silent !killall -USR1 sxhkd
  autocmd BufWritePost *Xresources silent !xrdb $XRESOURCES
  autocmd BufWritePost xsettingsd.conf silent !killall -HUP xsettingsd

  " Set executable bit to scripts on bin
  autocmd BufWritePost * if getline(1) =~ '^#!\(/usr\)\?/bin/' && expand('%:p:h') =~ '/bin$' | silent !chmod +x <afile> | endif

  " Set specific spell check languages for some files
  autocmd BufRead,BufNewFile */Code/* setlocal spelllang=en_us
augroup END

