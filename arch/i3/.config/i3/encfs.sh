#!/bin/bash
# Wrapper for the encfs mounter. After mounting, runs
# commands given as arguments.
# So i3 don't start those software before encfs is mounted.
#
# Rafael Cavalcanti
#

#SRC="/mnt/hdd-data/encrypted"
DEST="$HOME/Private"
MOUNT_SCRIPT=$HOME/.config/autostart-scripts/kdeencfs.sh

# Mount encfs
if mount | grep "$DEST" > /dev/null; then
	printf "Já está montado.\n"
else
	#kdeencfs.sh "$SRC" "$DEST"
	$MOUNT_SCRIPT
fi

# If mounted succesfully, start programs passed as arguments
if [[ $? == 0 && $# -gt 0 ]]; then
	for cmd do
		$cmd &
	done
	disown
fi
