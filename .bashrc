#
# ~/.bashrc
#
# Author: Rafael Cavalcanti - rafaelc.org

# If not running interactively, don't do anything (Arch)
[[ $- != *i* ]] && return

# [Debian/Ubuntu] chroot variable
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

GIT_PS1_SHOWDIRTYSTATE=1
. ~/.config/shell/git-prompt.sh

_pp_reset="\e[00m"
_pp_green="\e[01;32m"
_pp_blue="\e[01;34m"
_pp_light_grey="\e[37m"
_pp_title="\e]2;\w\a"
_pp_chroot="${debian_chroot:+($debian_chroot)}"
_pp_git="\$(__git_ps1)"

PS1="${_pp_title}\n"
PS1+="${_pp_chroot}${_pp_green}\u@\h${_pp_reset}: ${_pp_blue}\w ${_pp_light_grey}${_pp_git}"
PS1+="${_pp_reset}\n\$ "

# Prompt active tmux sessions
if [[ -z "$TMUX" ]]; then
	tmux_sessions="$(tmux ls 2>/dev/null | wc -l)"
	if [[ "$tmux_sessions" != "0" ]]; then
		printf "Sessões tmux ativas: %s\n" "$tmux_sessions"
	fi
fi

# Radline macros
# History completion with arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# For setting history length
HISTSIZE=2000
HISTFILESIZE=3000

# Time stamps in history
HISTTIMEFORMAT="%h/%d - %H:%M:%S "

# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Aliases definitions
. ~/.config/shell/aliases

# Arch's command not found - pkgfile (Arch Wiki)
if [ -f /usr/share/doc/pkgfile/command-not-found.bash ]; then
	. /usr/share/doc/pkgfile/command-not-found.bash
fi

# Workaround for having Git autocompletion on Mint 19
if [[ "$(cat /etc/issue 2> /dev/null)" == "Linux Mint 19."* ]]; then
	. /usr/share/bash-completion/completions/git
fi

# fzf
. /usr/share/doc/fzf/examples/completion.bash
. /usr/share/doc/fzf/examples/key-bindings.bash
