#
# ~/.zprofile
#
# Author: Rafael Cavalcanti <https://rafaelc.org/dev>

# User's private bin
if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi

# Move ~/.go to ~/.local
export GOPATH="$HOME/.local/go"

# Go's bin
if [ -d "$GOPATH/bin" ] ; then
	PATH="$GOPATH/bin:$PATH"
fi

# Rubygem user's bin
if command -v ruby >/dev/null; then
	PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"
fi

# RVM. Make sure this is the last PATH variable change.
if [ -d "$HOME/.rvm/bin" ]; then
	export PATH="$PATH:$HOME/.rvm/bin"
fi

# Termux: If connected via SSH, grab wake-lock
if [ "$HOST" = "localhost" ] && [ -n "${SSH_CLIENT:-}" ]; then
	printf "Grabbing wake-lock...\n" 1>&2
	termux-wake-lock
fi

# Use ssh-agent started by user's systemd if nothing running
if [ -z "$SSH_AUTH_SOCK" ]; then
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

# Auto logout on tty if inactive
if tty | grep -q tty; then TMOUT=120; fi

# Paths
export ALIASES="$HOME/.config/zsh/aliases"
export JUMPS="$HOME/.config/jumps.conf"
export NOTES="$HOME/Documents/Notes"
export XRESOURCES="$HOME/.config/X11/Xresources"
export WALLPAPERS="$HOME/Pictures/Wallpapers"

# Default applications
export BROWSER="chromium-freeworld"
export EDITOR="nvim"
export TERMINAL="st"


# Applications configuration
#######################################################

# aws-cli
# Move from ~/
export AWS_SHARED_CREDENTIALS_FILE="$HOME/.config/aws/credentials"
export AWS_CONFIG_FILE="$HOME/.config/aws/config"

# clipmenud
# This makes history persistent across sessions
export CM_DIR="$HOME/.cache"
export CM_IGNORE_WINDOW="KeePassXC"

# Docker
# Move from ~/
export DOCKER_CONFIG="$HOME/.config/docker"

# fd
export FD_ARGS="--follow --hidden --no-ignore-vcs"

# fzf
export FZF_DEFAULT_COMMAND="fd $FD_ARGS"
# Preview files with bat, directories with tree
export FZF_DEFAULT_OPTS="
	--layout=reverse
	--multi
	--preview '([[ -d {} ]] && tree -C {}) || ([[ -f {} ]] && bat --style=full --color=always --decorations=never {}) || echo {}'
	--bind 'change:top'
	--bind 'ctrl-t:top'
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

# npm: Move from ~/
export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc"

# texlive: Move from ~/
export TEXMFHOME="$HOME/.local/share/texmf"
export TEXMFVAR="$HOME/.cache/texlive/texmf-var"
export TEXMFCONFIG="$HOME/.config/texlive/texmf-config"

# zoxide
# Some changes from fzf default (like using the same height as fzf's ^R).
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --no-multi --no-preview --height 40%"
# Resolve symlinks before adding to DB: prevents duplicates
export _ZO_RESOLVE_SYMLINKS=1

# zsh: Move from ~/
export ZDOTDIR="$HOME/.config/zsh"

# Workaround as GDM on Fedora 36 doesn't read ~/.xprofile
# `-t 0` will test for interactivity, so this isn't source e.g. on tmux.
if [ "$XDG_SESSION_DESKTOP" = "dwm" ] && ! [ -t 0 ]; then
	. "$HOME/.config/X11/dwm_profile"
fi
