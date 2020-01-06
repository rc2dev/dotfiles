#
# ~/.profile
#
# Author: Rafael Cavalcanti

# Make sure HOSTNAME is set (Zsh sets HOST)
HOSTNAME=${HOSTNAME:-$(hostname)}

# User's private bin
if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi

# Termux user's bin
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

# User's Ruby gems
if command -v ruby >/dev/null; then
	PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
fi

# Add RVM to PATH for scripting
# Make sure this is the last PATH variable change.
if [ -d "$HOME/.rvm/bin" ]; then
	PATH="$PATH:$HOME/.rvm/bin"
fi

# Editor
export EDITOR="vim"

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
