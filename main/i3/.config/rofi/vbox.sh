#!/bin/bash
#
# Rofi modi for Virtualbox machines
# Rafael Cavalcanti
#

VBDIR="$HOME/VirtualBox VMs/"

if [ -z $@ ]
then
	ls "$VBDIR"
else
	VM=$@
	VBoxManage startvm "${VM}" >/dev/null &
	disown
fi
