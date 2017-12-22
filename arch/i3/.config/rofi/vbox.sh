#!/bin/bash
#
# Rofi modi for Virtualbox machines
# Rafael Cavalcanti
#

txt="$HOME/.config/rofi/vbox.txt"

if [ -z $@ ]
then
	cat "$txt"
else
	VM=$@
	VBoxManage startvm "${VM}" >/dev/null &
	disown
fi
