#
# ~/.zprofile
#
# Author: Rafael Cavalcanti <https://rafaelc.org/dev>

# User's private bin
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

# Auto logout on tty if inactive
if tty | grep -q tty; then TMOUT=120; fi

# ssh-agent
if [ -z "$SSH_AUTH_SOCK" ]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

# Used by mpv.conf
export HOSTNAME="$(hostname)"

# Paths
export NOTES="$HOME/Documents/Notes"
export XRESOURCES="$HOME/.config/X11/Xresources"

# Default applications
export BROWSER="/var/lib/flatpak/exports/bin/com.brave.Browser"
export DMENU="rofi -dmenu -i"
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
export CM_LAUNCHER="rofi"
export CM_HISTLENGTH=14  # set same value as rofi's theme

# fzf
export FZF_DEFAULT_OPTS="
  --layout=reverse
  --multi
  --bind 'change:top'
"

# man: Display the percentage into the document
export MANPAGER="less -s -M +Gg"

# npm: Move from ~/
export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc"

# texlive: Move from ~/
export TEXMFHOME="$HOME/.local/share/texmf"
export TEXMFVAR="$HOME/.cache/texlive/texmf-var"
export TEXMFCONFIG="$HOME/.config/texlive/texmf-config"

# w3m: Move from ~/
export W3M_DIR="$XDG_STATE_HOME/w3m"

# zsh: Move from ~/
export ZDOTDIR="$HOME/.config/zsh"

# zsh-z
export ZSHZ_CASE=smart
# Use my custom cd (with ls)
export ZSHZ_CD="cd"
# Move from ~/
export ZSHZ_DATA="$HOME/.local/state/zsh/z"
export ZSHZ_TILDE=1
# For lf / ranger integration
export ZSHZ_SRC="$HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-agkozak-SLASH-zsh-z/zsh-z.plugin.zsh"
