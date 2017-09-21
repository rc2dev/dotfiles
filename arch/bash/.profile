#
# ~/.profile
#
# Autor: Rafael Cavalcanti

# set PATH so it includes user's private bin if it exists (copiado do Ubuntu)
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Add Ruby gems to PATH
#if [ -d "$HOME/.gem/ruby/2.3.0/bin" ] ; then
#    PATH="$HOME/.gem/ruby/2.3.0/bin:$PATH"
#fi

# [RVM installation script] Add RVM to PATH for scripting. Make sure
# this is the last PATH variable change.
PATH="$PATH:$HOME/.rvm/bin"

# [RVM installation script]
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Adicionar meu diretório à busca de módulos do Python
# (https://docs.python.org/2/using/cmdline.html#envvar-PYTHONPATH)
#export PYTHONPATH="$HOME/code/python"

# Editor
#export EDITOR="vim"
export VISUAL="vim"

# Pacaur - don't use ~/.cache/pacaur
export AURDEST="$HOME/.pacaur"

# MPC: control Pi
export MPD_HOST="pi.lan"

# Atom - file deletion
export ELECTRON_TRASH=kioclient5

# KDE Plasma - SSH
# Run ssh-agent if it's not running (Arch Wiki)
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi
export SSH_ASKPASS="/usr/bin/ksshaskpass"

# Copiado do .bash_profile que removi - necessário para tty
# (é somente um source do bashrc)
[[ -f ~/.bashrc ]] && . ~/.bashrc

# i3
if [[ "$XDG_SESSION_DESKTOP" == "i3" ]]; then
	export TERMINAL=konsole
	# Workaround for QT5 applications to use correct theme
	export XDG_CURRENT_DESKTOP=KDE
	# For xdg-open to work (isto ou instalar Konqueror)
	export KDE_SESSION_VERSION=5
fi

