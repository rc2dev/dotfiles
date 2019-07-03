#!/bin/bash
# Based on https://faq.i3wm.org/question/5312/how-to-toggle-onoff-external-and-internal-monitors.1.html
#
# Rafael Cavalcanti

MODE_FILE="/tmp/display_mode_${USER}.dat"

if [ $# -ne 2 ]; then
	printf "Usage: $(basename "$0") primary_display secondary_display\n"
	exit
fi
primary_display="$1"
secondary_display="$2"

# if we don't have a file, start at zero
if [ ! -f "$MODE_FILE" ] ; then
  monitor_mode="all"

# otherwise read the value from the file
else
  monitor_mode=`cat $MODE_FILE`
fi

if [ $monitor_mode = "all" ]; then
        monitor_mode="EXTERNAL"
        xrandr --output $primary_display --off --output $secondary_display --auto
elif [ $monitor_mode = "EXTERNAL" ]; then
        monitor_mode="INTERNAL"
        xrandr --output $primary_display --auto --output $secondary_display --off
elif [ $monitor_mode = "INTERNAL" ]; then
        monitor_mode="CLONES"
        xrandr --output $primary_display --auto --output $secondary_display --auto --same-as $primary_display
else
        monitor_mode="all"
        xrandr --output $primary_display --auto --output $secondary_display --auto --left-of $primary_display
fi
echo "${monitor_mode}" > $MODE_FILE
