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

# Add my directory to Python search path for module files
# (https://docs.python.org/2/using/cmdline.html#envvar-PYTHONPATH)
#export PYTHONPATH="$HOME/code/python"

# Editor
#export EDITOR="vim"
export VISUAL="vim"

# Enable GNOME keyring for applications run through terminal (ArchWiki)
if [ -n "$DESKTOP_SESSION" ]; then
	eval $(gnome-keyring-daemon --start)
	export SSH_AUTH_SOCK
fi

# Start SSH agent (ArchWiki)
# This is not needed when using GNOME Keyring.
# This doesn't make sense on Termux, so we exclude it.
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

if [[ "$HOSTNAME" == "pi"* ]]; then
	/opt/scripts/pi/welcome
fi

