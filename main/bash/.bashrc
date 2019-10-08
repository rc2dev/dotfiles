#
# ~/.bashrc
#
# Author: Rafael Cavalcanti

# If not running interactively, don't do anything (veio do Arch)
[[ $- != *i* ]] && return

# [Debian/Ubuntu] chroot variable (copied)
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

# Set PS1
set_prompt() {
	local RESET="\e[0m"; local GREEN="\e[32m"; local YELLOW="\e[33m"
	local GREY="\e[90m"; local LGREY="\e[37m"

	local title="\e]2;\w\a"
	local chroot="${debian_chroot:+($debian_chroot)}"

	local rvm_possible=("~/.rvm" "/usr/local/rvm")
	for rvm_path in ${rvm_possible[@]}; do
		if [ -f ${rvm_path}/bin/rvm-prompt ]; then
			local rvm="\$(${rvm_path}/bin/rvm-prompt g)"
			break
		fi
	done

	echo "${title}\n${chroot}${GREEN}\u@\h: ${YELLOW}\w${LGREY} $git $rvm${RESET} \n\$ "
}
PS1=$(set_prompt)
unset set_prompt
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

# Alias definitions.
if [ -f ~/.config/bash_aliases/$HOSTNAME ]; then
	. ~/.config/bash_aliases/$HOSTNAME
else
	. ~/.config/bash_aliases/base
fi

# [Arch] Command not found - pkgfile (Arch Wiki)
if [ -f /usr/share/doc/pkgfile/command-not-found.bash ]; then
	. /usr/share/doc/pkgfile/command-not-found.bash
fi

# RVM: To work, moved from ~/.profile (RVM installation script added there)
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# NVM (added --no-use, so it isn't so slow)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

