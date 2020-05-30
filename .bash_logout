#
# ~/.bash_logout
#
# Rafael Cavalcanti
#

# Termux: We remove the wake-lock grabbed upon SSH connection
if [[ "$HOSTNAME" == "localhost" && -n "$SSH_CLIENT" ]]; then
	printf "You were connected via SSH. Disabling wake-lock.\n" 1>&2
	termux-wake-unlock
fi

