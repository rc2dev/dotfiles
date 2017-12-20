#!/bin/bash
#
# Wrapper for KWallet related startup operations on i3.
# Accepts commands as arguments to be executed at the end.
#
# Rafael Cavalcanti
#

# Seems necessary
/usr/lib/pam_kwallet_init

# SSH
~/.config/autostart-scripts/ssh-add.sh

# Mount encfs
~/.config/autostart-scripts/kdeencfs.sh

# Run commands passed as arguments
for cmd do
	$cmd &
done
