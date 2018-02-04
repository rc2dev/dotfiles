#
# ~/.bash_aliases for Termux
#
# Autor: Rafael Cavalcanti

# Also check command after sudo for alias (see man bash)
alias sudo="sudo "
alias watch="watch "

# Increase verbosity and prompt before overwriting (for rm, prompt
# before removing directory or more than 3 files)
alias cp="cp -vi"
alias mv="mv -vi"
alias rm="rm -vI"
alias ln="ln -vi"

# Human-readable output
alias df="df -h"
alias free="free -h"

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

# Browsing
alias gd="cd /sdcard/Download"
alias gS="cd /sdcard/Sync"
alias gr="cd $PREFIX"

