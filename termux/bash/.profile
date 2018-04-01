#
# ~/.profile (Termux)
#
# Rafael Cavalcanti

## If connected via SSH, try to avoid lag
#if [ -n "$SSH_CLIENT" ]; then
#	echo "Você está conectado por SSH: ativando wake-lock."
#	termux-wake-lock
#fi

if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

export EDITOR=vim
