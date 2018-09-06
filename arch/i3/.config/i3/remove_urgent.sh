#!/bin/sh
#
# Remove urgent hint at i3 startup
#
# Rafael Cavalcanti

# Wait i3 start-up
sleep 15

# Zim
wins=$(wmctrl -l -x | grep zim.Zim | awk '{print $1}')
for win in $wins; do
	wmctrl -i -r $win -b remove,demands_attention
done
