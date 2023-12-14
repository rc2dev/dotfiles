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
# Mute errors as in distrobox this command may not be available.
export HOSTNAME="$(hostname 2>/dev/null)"

# Set colors on ls, lf, zsh completion (set on zshrc)... Change exa colors from
# defaults.
if command -v vivid > /dev/null; then
  export LS_COLORS="$(vivid generate nord)"
fi

# XDG base directories
# Setting this isn't necessary, except config and data for moving less files
# from ~/ when using less version 590. No longer needed on version 600.
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Paths
export NOTES="$HOME/Documents/Notes"
export XRESOURCES="$HOME/.config/X11/Xresources"
# Move from ~/. Note this doesn't work on some DM's.
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority

# Default applications
# Setting this on Termux breaks opening urls from gh.
if [[ -z "${TERMUX_VERSION:-}" ]]; then
  export BROWSER="chromium"
fi
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

# go: Move from ~/
export GOPATH="$HOME/.local/share/go"

# man: Display the percentage into the document
export MANPAGER="less -s -M +Gg"

# npm: Move from ~/
export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc"

# texlive: Move from ~/
export TEXMFHOME="$HOME/.local/share/texmf"
export TEXMFVAR="$HOME/.cache/texlive/texmf-var"
export TEXMFCONFIG="$HOME/.config/texlive/texmf-config"

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


# Autostart X11 on tty1
#######################################################

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx &> /dev/null
fi
