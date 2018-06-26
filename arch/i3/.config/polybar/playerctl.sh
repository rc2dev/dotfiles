#!/bin/bash
#
# Print Playerctl metadata - for Polybar
# Rafael Cavalcanti

#player="-p spotify"

artist="$(playerctl $player metadata xesam:artist)"
title="$(playerctl $player metadata xesam:title)"
stat="$(playerctl $player status)"

case "$stat" in
	Paused)
		symb=" "
		;;
	Playing)
		symb=" "
		;;
esac

if [[ "$artist" == "" || "$title" == "" ]]
then
	printf "%s No info" "$symb"
else
	printf "%s %s - %s\n" "$symb" "$artist" "$title"
fi
