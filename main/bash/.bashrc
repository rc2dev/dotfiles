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

# Prepare Git prompt to PS1
if [ -f ~/.local/share/git-prompt.sh ]; then
	git="\$(__git_ps1)"
	GIT_PS1_SHOWDIRTYSTATE=1
	. ~/.local/share/git-prompt.sh
fi

build_ps1() {
	local RESET="\e[00m"
	local GREEN="\e[01;32m"
	local BLUE="\e[01;34m"
	local LGREY="\e[37m"

	local title="\e]2;\w\a"
	local chroot="${debian_chroot:+($debian_chroot)}"

	local rvm_possible=("~/.rvm" "/usr/local/rvm")
	for rvm_path in ${rvm_possible[@]}; do
		if [ -f ${rvm_path}/bin/rvm-prompt ]; then
			local rvm="\$(${rvm_path}/bin/rvm-prompt g)"
			break
		fi
	done

	echo "${title}\n${chroot}${GREEN}\u@\h${RESET}: ${BLUE}\w${LGREY} $git $rvm${RESET} \n\$ "
}
PS1=$(build_ps1)
unset build_ps1
unset git

# Prompt active tmux sessions
if ! { [[ "$TERM" == "screen" ]] && [[ -n "$TMUX" ]]; } then
	tmux_sessions="$(tmux ls 2>/dev/null | wc -l)"
	if [[ "$tmux_sessions" != "0" ]]; then
		printf "Sessões tmux ativas: %s\n" $tmux_sessions
	fi
fi

# History completion with arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# cd without cd
shopt -s autocd

# For setting history length
HISTSIZE=2000
HISTFILESIZE=3000

# Time stamps in history
HISTTIMEFORMAT="%h/%d - %H:%M:%S "

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Alias definitions
if [ -f ~/.bash_aliases/$HOSTNAME ]; then
	. ~/.bash_aliases/$HOSTNAME
else
	. ~/.bash_aliases/base
fi

# Arch's command not found - pkgfile (Arch Wiki)
if [ -f /usr/share/doc/pkgfile/command-not-found.bash ]; then
	. /usr/share/doc/pkgfile/command-not-found.bash
fi

# Workaround for having Git autocompletion on Mint 19
if [[ "$(cat /etc/issue 2> /dev/null)" == "Linux Mint 19."* ]]; then
	. /usr/share/bash-completion/completions/git
fi

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# NVM (added --no-use, so it isn't so slow)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

