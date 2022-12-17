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

# Use ssh-agent started by user's systemd if nothing running
if [ -z "$SSH_AUTH_SOCK" ]; then
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

# Auto logout on tty if inactive
if tty | grep -q tty; then TMOUT=120; fi

# Paths
export NOTES="$HOME/Documents/Notes"
export XRESOURCES="$HOME/.config/X11/Xresources"

# Default applications
export BROWSER="/var/lib/flatpak/exports/bin/com.brave.Browser"
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

# fzf
# Preview files with bat, directories with tree
export FZF_DEFAULT_OPTS="
	--layout=reverse
	--multi
	--preview '([[ -d {} ]] && tree -C {}) || ([[ -f {} ]] && bat --style=full --color=always --decorations=never {}) || echo {}'
	--bind 'change:top'
"
# One Dark theme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
	--color=dark
	--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
	--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
'

# man: Display the percentage into the document
export MANPAGER="less -s -M +Gg"

# npm: Move from ~/
export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc"

# ranger
# Use two spaces instead of one.
export RANGER_DEVICONS_SEPARATOR="  "

# texlive: Move from ~/
export TEXMFHOME="$HOME/.local/share/texmf"
export TEXMFVAR="$HOME/.cache/texlive/texmf-var"
export TEXMFCONFIG="$HOME/.config/texlive/texmf-config"

# zsh: Move from ~/
export ZDOTDIR="$HOME/.config/zsh"

# zsh-z
export ZSHZ_DATA="$HOME/.local/share/zsh-z/z"
mkdir -p "$(dirname "$ZSHZ_DATA")"
# For ranger plugin
export ZSHZ_SRC="$HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-agkozak-SLASH-zsh-z/zsh-z.plugin.zsh"

# Workaround as some DM's don't source ~/.xprofile.
# `-t 0` will test for interactivity, so this isn't source e.g. on tmux.
if [ "$XDG_SESSION_DESKTOP" = "dwm" ] && ! [ -t 0 ]; then
	. "$HOME/.config/X11/dwm_profile"
fi
