#
# ~/.bash_logout
#
# Rafael Cavalcanti

# If connected via SSH, we now remove the wake-lock grabbed upon connection
if [ -n "$SSH_CLIENT" ]; then
	echo "Você estava conectado por SSH. Desativando wake-lock."
	termux-wake-unlock
fi
