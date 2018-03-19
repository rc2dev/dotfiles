#!/bin/sh
#
# Rafael Cavalcanti

vbox="~/.config/rofi/vbox.sh"
vnc="~/.config/rofi/vnc.sh"

rofi -combi-modi window,drun,ssh,vnc:$vnc,vbox:$vbox,run -show combi \
	-modi combi,ssh,vnc:$vnc,vbox:$vbox -display-combi ""
