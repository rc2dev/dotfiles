" Autocommands
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

augroup rc2dev
  autocmd!

  " Resize splits automatically if VIM is resized
  autocmd VimResized * execute "normal! \<C-w>="

  " Start terminal on insert mode
  autocmd TermOpen * startinsert

  " Run these commands whenever these files are updated
  autocmd BufWritePost dwm-status silent !dwm-status & disown
  autocmd BufWritePost ~/.config/dunst/* silent !killall dunst
  autocmd BufWritePost sxhkdrc silent !killall -USR1 sxhkd
  autocmd BufWritePost *Xresources silent !xrdb $XRESOURCES && killall -USR1 st
  autocmd BufWritePost xsettingsd.conf silent !killall -HUP xsettingsd
augroup END

