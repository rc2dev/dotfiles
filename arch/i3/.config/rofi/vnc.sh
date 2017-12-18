#!/bin/bash
#
# Rofi modi for VNC machines
# Dependencies: my vnc script
#
# Rafael Cavalcanti
#

hosts="romildo.lan\nrosa.lan\nrafael-r509.lan\npi.lan\nvpi"

if [ -z $@ ]
then
	printf "$hosts" | sort
	#grep "Host" ~/.ssh/config | awk '$2!="*"{print $2}' | sort
else
	host=$@
	vnc "${host}" >/dev/null &
	disown
fi
