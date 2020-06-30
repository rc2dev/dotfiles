#
# ~/.profile
#
# Author: Rafael Cavalcanti - rafaelc.org

# Make sure HOSTNAME is set (Zsh sets HOST)
HOSTNAME=${HOSTNAME:-$(hostname)}

# User's private bin
if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi

# Termux: User's private bin
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

# Scripts
if [ -d "/opt/scripts/general" ]; then
	PATH="/opt/scripts/general:$PATH"
fi

# Rubygem user's bin
if command -v ruby >/dev/null; then
	PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"
fi

export EDITOR="vim"

if command -v mpc >/dev/null; then
	export MPD_HOST="192.168.15.101"
fi

# Start OpenSSH agent (ArchWiki)
# We exclude Termux, as this doesn't make sense for it.
if [[ "$HOSTNAME" != "localhost" ]]; then
	if ! pgrep -u "$USER" ssh-agent > /dev/null; then
		ssh-agent > ~/.ssh-agent-thing
	fi
	if [[ ! "$SSH_AUTH_SOCK" ]]; then
		eval "$(<~/.ssh-agent-thing)"
	fi
fi

# Termux: if connected via SSH, grab wake-lock
if [[ "$HOSTNAME" == "localhost" && -n "$SSH_CLIENT" ]]; then
	printf "Grabbing wake-lock...\n" 1>&2
	termux-wake-lock
fi

# WSL: fix umask
if [[ "$(umask)" == "0000" ]]; then
	umask 0027
fi

# Make Qt use GTK style
# Be sure to install qt5-style-plugins
if [[ -n $DISPLAY ]]; then
	export QT_QPA_PLATFORMTHEME=gtk2
fi
