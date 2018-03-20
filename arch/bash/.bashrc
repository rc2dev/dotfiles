#
# ~/.bashrc
#
# Autor: Rafael Cavalcanti

# If not running interactively, don't do anything (veio do Arch)
[[ $- != *i* ]] && return

# [Debian/Ubuntu] chroot variable (copied)
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Meu PS1 (estilo Cygwin + Git + RVM)
RESET="\e[0m"; GREEN="\e[32m"; YELLOW="\e[33m"; GREY="\e[90m"; LGREY="\e[37m"
title="\e]2;\w\a"
chroot="${debian_chroot:+($debian_chroot)}"
if [ -f ~/.local/share/git-prompt.sh ]
then
	. ~/.local/share/git-prompt.sh
	git="\$(__git_ps1)"
	GIT_PS1_SHOWDIRTYSTATE=1
fi
if [ -f ~/.rvm/bin/rvm-prompt ]
then
	rvm="\$(~/.rvm/bin/rvm-prompt p g)"
fi
PS1="${title}\n${chroot}${GREEN}\u@\h: ${YELLOW}\w${LGREY} \$(__git_ps1) $rvm${RESET} \n\$ "

# History completion with arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# For setting history length
# [RC modified] HISTSIZE=1000->2000, HISTFILESIZE: 2000->3000
HISTSIZE=2000
HISTFILESIZE=3000

# Time stamps in history
HISTTIMEFORMAT="%h/%d - %H:%M:%S "

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# [Arch] Command not found - pkgfile (Arch Wiki)
nf="/usr/share/doc/pkgfile/command-not-found.bash"
[ -f "$nf" ] && . "$nf"

# [RVM installation script] Add RVM to PATH for scripting. Make sure
# this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

