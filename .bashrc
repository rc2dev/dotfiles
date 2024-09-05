# ~/.bashrc
#
# Used on some systems such as dietpi.
# Based on Debian skel's bashrc.
# Author: Rafael Cavalcanti <dev@rafaelc.org>

# If not running interactively, don't do anything
# or e.g. rsync may throw warnings on some commands
[[ $- != *i* ]] && return

# Don't save lines starting with space to history
HISTCONTROL=ignorespace

# Append to the history file, don't overwrite it
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# History completion
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Colorful PS1
PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# zoxide
eval "$(zoxide init bash)"

# aliases
source "$HOME/.config/zsh/aliases"

# as .zprofile is not sourced...
export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"
