#
# ~/.zprofile
#
# Author: Rafael Cavalcanti - rafaelc.org

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

# Termux: Set runtime dir
if [[ "$HOST" == "localhost" && -z "$XDG_RUNTIME_DIR" ]]; then
	export XDG_RUNTIME_DIR="$PREFIX/var/run"
fi

# Termux: Start OpenSSH agent if needed
if [[ "$HOST" == "localhost" && -z "$SSH_AUTH_SOCK" ]]; then
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.sock"
	rm -f "$SSH_AUTH_SOCK"
	ssh-agent -t 1h -a "$SSH_AUTH_SOCK" > /dev/null
fi

# Termux: if connected via SSH, grab wake-lock
if [[ "$HOST" == "localhost" && -n "$SSH_CLIENT" ]]; then
	printf "Grabbing wake-lock...\n" 1>&2
	termux-wake-lock
fi

# Make Qt use GTK style
# Be sure to install qt5-style-plugins
export QT_QPA_PLATFORMTHEME=gtk2

# Check slow host
if [[ " pi pi-vcc pizero " =~ " $HOST " ]]; then
	export SLOW_HOST=1
fi

# Paths
export ALIASES="$HOME/.config/aliases"
export NOTES="$HOME/Sync/.Notes/md"
export WALLPAPERS="$HOME/Pictures/Wallpapers"

# Default applications
export EDITOR="vim"
export TERMINAL="alacritty"


# Applications configuration
#######################################################

# clipmenud
# This fixes losing the clipboard content when closing the source application
export CM_OWN_CLIPBOARD=1
# This makes history persistent across sessions
export CM_DIR="$HOME/.cache"

# cmus
# Move configuration
CMUS_HOME="$HOME/Documents/cmus"

# fzf
export FD_FILES="fd --follow --hidden --no-ignore-vcs --exclude '*.git' --exclude 'node_modules' ."
export FD_DIRS="fd --follow --hidden --no-ignore-vcs -t d ."
export FZF_DEFAULT_COMMAND="$FD_FILES"
export FZF_DEFAULT_OPTS="
	--layout=reverse
	--height 40%
	--multi
	--bind 'ctrl-a:select-all'
	--bind 'ctrl-y:execute-silent(echo {+} | xclip -selection clipboard)'
"

# mpd
export MPD_HOST="192.168.15.101"

# taskwarrior
export TASKRC="$HOME/Sync/Apps/Taskwarrior/taskrc"

# z.lua
# Move out from ~/
export _ZL_DATA="/home/rafael/.local/share/zlua"
export RANGER_ZLUA="$HOME/.local/opt/z.lua/z.lua"

# Zsh configuration
# Needed for last-working-dir plugin; and I use it in other places
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
mkdir -p "$ZSH_CACHE_DIR"
# Move from ~/
export ZDOTDIR="$HOME/.config/zsh"
export ADOTDIR="$ZSH_CACHE_DIR/antigen"

