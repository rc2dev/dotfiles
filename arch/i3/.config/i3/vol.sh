#!/usr/bin/env bash
#
# Do volume operations with notifications
# Rafael Cavalcanti

SINK="@DEFAULT_SINK@"

usage() {
	cat << EOF
Usage: $0 [option]

Options:
  -u      Increase volume
  -d      Decrease volume
  -m      Toggle mute
EOF
	exit 1
}

# Increase volume
increase() {
	pactl set-sink-volume "$SINK" +5%
	volnoti-show "$(amixer get Master | grep -Po "[0-9]+(?=%)" | tail -1)"
}

# Decrease volume
decrease() {
	pactl set-sink-volume "$SINK" -5%
	volnoti-show "$(amixer get Master | grep -Po "[0-9]+(?=%)" | tail -1)"
}

# Toggle mute
mute() {
	pactl set-sink-mute "$SINK" toggle
	if amixer get Master | grep -Fq "[off]"
	then
		volnoti-show -m
	else
		volnoti-show "$(amixer get Master | grep -Po "[0-9]+(?=%)" | tail -1)"
	fi
}

# Check number of args
if [ "$#" -ne "1" ]
then
	usage
fi

case $1 in
	-m)
		mute
		;;
	-u)
		increase
		;;
	-d)
		decrease
		;;
	*)
		usage
		;;
esac

