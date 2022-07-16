#
# ~/.zprofile
#
# Author: Rafael Cavalcanti <https://rafaelc.org/dev>

# Set HOST if unset
export HOST="${HOST:-$(hostname)}"

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

# Termux: If connected via SSH, grab wake-lock
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
export JUMPS="$HOME/.config/jumps.conf"
export NOTES="$HOME/Documents/Notes"
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
export CM_IGNORE_WINDOW="KeePassXC"

# fd
export FD_ARGS="--follow --hidden --no-ignore-vcs"

# fzf
export FZF_DEFAULT_COMMAND="fd $FD_ARGS"
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
# Dracula theme
# Removed bg:#282a36 for transparent bg
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
	--color=fg:#f8f8f2,hl:#bd93f9
	--color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9
	--color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6
	--color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4
'

# man: Display the percentage into the document
export MANPAGER="less -s -M +Gg"

# zoxide
# Automatically accept if one entry and changes from default
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --select-1 --no-multi --preview 'tree {2..}'"
# Resolve symlinks before adding to DB: prevents duplicates
export _ZO_RESOLVE_SYMLINKS=1
# $HOME is excluded by default. Also exclude directories with network mount points.
# Use `whoami` instead of `$USER`, or termux-url-open fails.
export _ZO_EXCLUDE_DIRS="$HOME:/media/$(whoami):/media/$(whoami)/*"

# zsh: Move from ~/
export ZDOTDIR="$HOME/.config/zsh"

