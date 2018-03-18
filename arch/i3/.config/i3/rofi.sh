#!/bin/sh
#
# Rafael Cavalcanti

vbox="~/.config/rofi/vbox.sh"
vnc="~/.config/rofi/vnc.sh"

rofi -no-lazy-grab -combi-modi window,drun,vbox:$vbox,run,ssh,vnc:$vnc -show combi \
	-modi combi,vbox:$vbox,ssh,vnc:$vnc
