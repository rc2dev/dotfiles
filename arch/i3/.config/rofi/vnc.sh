#!/bin/bash
#
# Rofi modi for VNC machines
# Dependencies: my vnc script
#
# Rafael Cavalcanti
#

hosts="pi.lan\nrafael-r509.lan\nromildo.lan\nrosa.lan\nvcc.lan"

if [ -z $@ ]
then
	printf "$hosts" | sort
	#grep "Host" ~/.ssh/config | awk '$2!="*"{print $2}' | sort
else
	host=$@
	vnc "${host}" >/dev/null &
	disown
fi
