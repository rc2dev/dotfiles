#
# ~/.profile
#
# Autor: Rafael Cavalcanti

# set PATH so it includes user's private bin if it exists (copiado do Ubuntu
# e local modificado)
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# [RVM installation script - RC condicionado] Add RVM to PATH for scripting
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
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
	ssh-agent -t 1800 > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
	eval "$(<~/.ssh-agent-thing)"
fi

