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

# [RVM installation script]
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Adicionar meu diretório à busca de módulos do Python
# (https://docs.python.org/2/using/cmdline.html#envvar-PYTHONPATH)
#export PYTHONPATH="$HOME/code/python"

# Editor
#export EDITOR="vim"
export VISUAL="vim"

# Pacaur - don't use ~/.cache/pacaur
if command -v pacaur >/dev/null; then
	export AURDEST="$HOME/.pacaur"
fi

# MPC - control Pi
if command -v mpc >/dev/null; then
	export MPD_HOST="pi.lan"
fi

