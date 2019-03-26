#!/bin/sh
#
# Associate this script with a key, and assign the file manager
# to the scratchpad.
# Now, when pressing the key, the file manager will be shown,
# and started when needed.
#
# Rafael Cavalcanti

class="dolphin"
binary="dolphin"

if ! xdotool search --classname "$class" > /dev/null; then
	echo "FE not detected, running..."
	"$binary" &
	sleep 0.5
fi

echo "Showing/hiding FE..."
i3-msg [class="$class"] scratchpad show
