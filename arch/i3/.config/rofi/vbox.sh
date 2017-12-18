#!/bin/bash
#
# Rofi modi for Virtualbox machines
# Rafael Cavalcanti
#

if [ -z $@ ]
then
	VBoxManage list vms -s | awk -F'"' '{print $2}'
else
	VM=$@
	VBoxManage startvm "${VM}" >/dev/null &
	disown
fi
