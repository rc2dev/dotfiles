#
# ~/.profile
#
# Autor: Rafael Cavalcanti

# user's private bin
if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi

# Termux user's bin
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

# [RVM installation script - RC condition] Add RVM to PATH for scripting
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

# MPC - control Pi
if command -v mpc >/dev/null; then
	export MPD_HOST="pi.lan"
fi

# Run ssh-agent if it's not running (Arch Wiki)
# Don't do it for Termux
if [[ "$HOSTNAME" != "localhost" ]]; then
	# Set timeout for specific hosts
	[[ "$HOSTNAME" != "costanza" ]] && timeout="-t 1800"
	if ! pgrep -u "$USER" ssh-agent > /dev/null; then
		ssh-agent $timeout > ~/.ssh-agent-thing
	fi
	if [[ "$SSH_AGENT_PID" == "" ]]; then
		eval "$(<~/.ssh-agent-thing)"
	fi
	unset timeout
fi

# Termux: if connected via SSH, grab wake-lock
if [[ "$HOSTNAME" == "localhost" && -n "$SSH_CLIENT" ]]; then
	printf "Connected via SSH. Grabbing wake-lock.\n"
	termux-wake-lock
fi

