#
# ~/.bash_logout
#
# Rafael Cavalcanti
#

# Termux: We remove the wake-lock grabbed upon SSH connection
if [[ "$HOSTNAME" == "localhost" && -n "$SSH_CLIENT" ]]; then
	printf "You were connected via SSH. Disabling wake-lock.\n"
	termux-wake-unlock
fi

