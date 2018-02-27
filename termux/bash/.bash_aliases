#
# ~/.bash_aliases for Termux
#
# Autor: Rafael Cavalcanti

# Also check command after sudo for alias (see man bash)
alias sudo="sudo "
alias watch="watch "

# Increase verbosity and prompt before overwriting
alias cp="cp -vi"
alias mv="mv -vi"
alias rm="rm -v"
alias ln="ln -v"

# Human-readable output
alias df="df -h"
alias free="free -m"

# Coloured output
alias ls="ls --color=auto"
alias grep="grep --color=auto"
#alias fgrep='fgrep --color=auto'
#alias egrep='egrep --color=auto'

# Easy access to ls options
alias la="ls -a"
alias ll="ls -lh"

# Bash commands
alias c="clear"
alias x="exit"

# Update
alias update="~/bin/update"

# Browsing
alias g.="cd ~/.dotfiles/termux"
alias gs="cd ~/.scripts"
alias gd="cd /sdcard/Download"
alias gS="cd /sdcard/Sync"
alias ge="cd /sdcard/Sync/Para\ enviar"
alias gr="cd $PREFIX"

# Multimedia
alias yu="youtube-dl --get-url"
alias ya="youtube-dl --extract-audio"
alias ym="youtube-dl --extract-audio --audio-format mp3"
alias y480="youtube-dl -f 'bestvideo[height<=480]+bestaudio/best[height<=480]' --recode-video mp4"
cv_path="bash ~/bin/convert-video"
alias convert-video="$cv_path"
alias cs="$cv_path --to-small"
alias c4="$cv_path --to-mp4"
c3() {
 ffmpeg -i "$1" "${1%.*}.mp3"
}

