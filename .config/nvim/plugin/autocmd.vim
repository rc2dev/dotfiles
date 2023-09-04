" Autocommands
" Author: Rafael Cavalcanti <https://rafaelc.org/dev>

augroup rc2dev
  autocmd!

  " Resize splits automatically if VIM is resized
  autocmd VimResized * execute "normal! \<C-w>="

  " Run these commands whenever these files are updated
  autocmd BufWritePost dwmbar silent !dwmbar
  autocmd BufWritePost ~/.config/dunst/* silent !killall dunst && dunst & disown
  autocmd BufWritePost ~/.config/jumps.conf silent !gen-jumps
  autocmd BufWritePost sxhkdrc silent !killall -USR1 sxhkd
  autocmd BufWritePost *Xresources silent !xrdb $XRESOURCES && killall -USR1 st
  autocmd BufWritePost xsettingsd.conf silent !killall -HUP xsettingsd

  " Set specific spell check languages for some files
  autocmd BufRead,BufNewFile */dev/* setlocal spelllang=en_us
augroup END

