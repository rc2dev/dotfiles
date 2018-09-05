#!/bin/sh
#
# Associate this script with a key, and assign the file manager
# to the scratchpad.
# Now, when pressing the key, the file manager will be shown,
# and started when needed.
#
# Rafael Cavalcanti


if ! xdotool search --classname "dolphin" > /dev/null; then
	echo "Dolphin not detected, running..."
	dolphin &
	sleep 0.4
fi

echo "Showing/hiding Dolphin..."
i3-msg [class="dolphin"] scratchpad show
