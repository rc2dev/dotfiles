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
		symb1=" %{F#aaa}"
		symb2="%{F-}"
		;;
	Playing)
		symb1=" "
		;;
	*)
		symb1="%{F#aaa}"
		symb2="%{F-}"
esac

if [[ "$artist" == "" || "$title" == "" ]]
then
	printf "%s No info%s" "$symb1" "$symb2"
else
	printf "%s %s - %s%s\n" "$symb1" "$artist" "$title" "$symb2"
fi
