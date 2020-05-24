#
# ~/.bashrc
#
# Author: Rafael Cavalcanti

# If not running interactively, don't do anything (Arch)
[[ $- != *i* ]] && return

# [Debian/Ubuntu] chroot variable
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

build_ps1() {
	local -r reset="\e[00m"
	local -r green="\e[01;32m"
	local -r blue="\e[01;34m"
	local -r light_grey="\e[37m"
	local -r title="\e]2;\w\a"
	local -r chroot="${debian_chroot:+($debian_chroot)}"
	local -r git="\$(__git_ps1)"

	local -r rvm_paths=("$HOME/.rvm" "/usr/local/rvm")
	for rvm_path in "${rvm_paths[@]}"; do
		if [[ -f "${rvm_path}/bin/rvm-prompt" ]]; then
			local -r rvm="\$(${rvm_path}/bin/rvm-prompt g)"
			break
		fi
	done

	GIT_PS1_SHOWDIRTYSTATE=1
	. ~/.config/shell/git-prompt.sh

	PS1="${title}\n${chroot}${green}\u@\h${reset}: ${blue}\w${light_grey} ${git} ${rvm}${reset} \n\$ "
}
build_ps1

# Prompt active tmux sessions
if ! { [[ "$TERM" == "screen" ]] && [[ -n "$TMUX" ]]; } then
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

# cd without cd
shopt -s autocd

# Alias definitions
ALIASES_DIR="$HOME/.config/shell/aliases"
if [ -f "$ALIASES_DIR/$HOSTNAME" ]; then
	. "$ALIASES_DIR/$HOSTNAME"
else
	. "$ALIASES_DIR/base"
fi

# Arch's command not found - pkgfile (Arch Wiki)
if [ -f /usr/share/doc/pkgfile/command-not-found.bash ]; then
	. /usr/share/doc/pkgfile/command-not-found.bash
fi

# Workaround for having Git autocompletion on Mint 19
if [[ "$(cat /etc/issue 2> /dev/null)" == "Linux Mint 19."* ]]; then
	. /usr/share/bash-completion/completions/git
fi
