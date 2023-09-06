" Autocommands
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

augroup rc2dev
  autocmd!

  " Resize splits automatically if VIM is resized
  autocmd VimResized * execute "normal! \<C-w>="

  " Run these commands whenever these files are updated
  autocmd BufWritePost dwm-status silent !dwm-status & disown
  autocmd BufWritePost ~/.config/dunst/* silent !killall dunst
  autocmd BufWritePost ~/.config/jumps.conf silent !gen-jumps
  autocmd BufWritePost sxhkdrc silent !killall -USR1 sxhkd
  autocmd BufWritePost *Xresources silent !xrdb $XRESOURCES && killall -USR1 st
  autocmd BufWritePost xsettingsd.conf silent !killall -HUP xsettingsd

  " Set specific spell check languages for some files
  autocmd BufRead,BufNewFile */dev/default/* setlocal spelllang=en_us
augroup END

