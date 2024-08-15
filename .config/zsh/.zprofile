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

# XDG base directories
# Setting this isn't necessary, except config and data for moving less files
# from ~/ when using less version 590. No longer needed on version 600.
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Move from ~/. Note this doesn't work on some DM's.
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority

# Default applications
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
  export DMENU="wofi --cache-file=/dev/null -dmenu -i"
else
  export DMENU="rofi -dmenu -i"
fi
export EDITOR="nvim"

# For Qt applications under GNOME Wayland
if [[ "$XDG_SESSION_TYPE" == "wayland" && "$XDG_SESSION_DESKTOP" == "gnome" ]]; then
  # Fix cursor size and window decorations
  export QT_QPA_PLATFORMTHEME=gnome

  # Fix cursor size on some applications
  export XCURSOR_SIZE="$(gsettings get org.gnome.desktop.interface cursor-size)"

  # Disable window decoration
  export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
fi


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

# fzf
export FZF_DEFAULT_OPTS="
  --layout=reverse
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

# zoxide:
# - Keep queries sorted by score when typing on interactive mode
# (<https://github.com/ajeetdsouza/zoxide/issues/102)
# - Add preview window
export _ZO_FZF_OPTS="
  --no-sort
  --height 70%
  --preview 'ls -1 --color {2..}' --preview-window 40% $FZF_DEFAULT_OPTS
"


# Autostart X11 on tty1
#######################################################

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx &> /dev/null
fi
