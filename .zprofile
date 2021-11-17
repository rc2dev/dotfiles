#
# ~/.zprofile
#
# Author: Rafael Cavalcanti - rafaelc.org

# Set HOST if unset
export HOST="${HOST:-$(hostname)}"

# Flatpaks
if [ -d "/var/lib/flatpak/exports/bin" ]; then
	PATH="/var/lib/flatpak/exports/bin:$PATH"
fi

# User's private bin
if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi

# Rubygem user's bin
if command -v ruby >/dev/null; then
	PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"
fi

# Cargo's bin
if [ -d "$HOME/.cargo/bin" ]; then
	PATH="$HOME/.cargo/bin:$PATH"
fi

# Anaconda
if [ -d "$HOME/.local/opt/anaconda3/bin" ]; then
	PATH="$HOME/.local/opt/anaconda3/bin:$PATH"
fi

# RVM. Make sure this is the last PATH variable change.
if [ -d "$HOME/.rvm/bin" ]; then
	export PATH="$PATH:$HOME/.rvm/bin"
fi

# Termux: Set runtime dir
if [[ "$HOST" == "localhost" && -z "${XDG_RUNTIME_DIR:-}" ]]; then
	export XDG_RUNTIME_DIR="$PREFIX/var/run"
fi

# Termux: Start OpenSSH agent if needed
if [[ "$HOST" == "localhost" && -z "${SSH_AUTH_SOCK:-}" ]]; then
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.sock"
	rm -f "$SSH_AUTH_SOCK"
	ssh-agent -t 1h -a "$SSH_AUTH_SOCK" > /dev/null
fi

# Termux: if connected via SSH, grab wake-lock
if [[ "$HOST" == "localhost" && -n "${SSH_CLIENT:-}" ]]; then
	printf "Grabbing wake-lock...\n" 1>&2
	termux-wake-lock
fi

# Make Qt use GTK style
# Be sure to install qt5-style-plugins
export QT_QPA_PLATFORMTHEME=gtk2

# Auto logout on tty if inactive
if [[ $(tty) =~ /dev\/tty ]]; then TMOUT=120; fi

# Check slow host
if [[ " pi pi-vcc pizero " =~ " $HOST " ]]; then
	export SLOW_HOST=1
fi

# Paths
export ALIASES="$HOME/.config/zsh/aliases"
export NOTES="$HOME/Sync/.Notes"
export XRESOURCES="$HOME/.config/X11/Xresources"
export WALLPAPERS="$HOME/Pictures/Wallpapers"

# Default applications
export EDITOR="vim"
export TERMINAL="st"


# Applications configuration
#######################################################

# clipmenud
# This makes history persistent across sessions
export CM_DIR="$HOME/.cache"

# cmus: Move configuration
CMUS_HOME="$HOME/Documents/cmus"

# fzf
export FD_FILES="fd --follow --hidden --no-ignore-vcs --exclude '.git' --exclude 'node_modules' ."
export FD_DIRS="$FD_FILES -t d ."
export FZF_DEFAULT_COMMAND="$FD_FILES"
# Preview files with bat, directories with tree
export FZF_DEFAULT_OPTS="
	--layout=reverse
	--height 40%
	--multi
	--preview '([[ -d {} ]] && tree -C {}) || ([[ -f {} ]] && bat --style=full --color=always --decorations=never {}) || echo {}'
	--bind 'change:top'
	--bind 'ctrl-a:select-all'
	--bind 'ctrl-t:top'
	--bind 'ctrl-y:execute-silent(echo {+} | xclip -selection clipboard)'
"
# Nord theme
# Removed bg:#2e3440 and preview-bg:#2e3440, for transparent bg
#export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
	#--color=bg+:#4c566a,fg:#e5e9f0
	#--color=fg+:#eceff4,hl:#88c0d0,hl+:#81a1c1
	#--color=preview-fg:#e5e9f0
	#--color=border:#4c566a,gutter:#3b4252,header:#88c0d0
	#--color=info:#88c0d0,marker:#88c0d0,pointer:#81a1c1
	#--color=prompt:#88c0d0,spinner:#88c0d0'
# Dracula theme
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

# less: Have less (and man) display colours
# From: https://unix.stackexchange.com/a/329092 and
#       https://wiki.archlinux.org/index.php/Color_output_in_console#man
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
#export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
#export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminals

# man: Dsplay the percentage into the document
export MANPAGER="less -s -M +Gg"

# taskwarrior
export TASKRC="$HOME/Sync/Apps/Taskwarrior/taskrc"

# xidlehook
export XIDLEHOOK_SOCK="$XDG_RUNTIME_DIR/xidlehook.sock"

# zoxide
export _ZO_EXCLUDE_DIRS="/mnt:/media"

# zsh: Move from ~/
export ZDOTDIR="$HOME/.config/zsh"

