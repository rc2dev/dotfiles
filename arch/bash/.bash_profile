# ~/.bash_profile

# [RC] Necessary for login shells
[ -f ~/.bashrc ] && . ~/.bashrc

# Autostart X on tty1
[ -z "$DISPLAY" -a $XDG_VTNR -eq 1 ] && startx
