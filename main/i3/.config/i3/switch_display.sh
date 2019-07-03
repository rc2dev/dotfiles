#!/bin/bash
# Based on https://faq.i3wm.org/question/5312/how-to-toggle-onoff-external-and-internal-monitors.1.html
#
# Rafael Cavalcanti

EXTERNAL_OUTPUT="DP-1"
INTERNAL_OUTPUT="HDMI-1"

MODE_FILE="/tmp/display_mode_${USER}.dat"

# if we don't have a file, start at zero
if [ ! -f "$MODE_FILE" ] ; then
  monitor_mode="all"

# otherwise read the value from the file
else
  monitor_mode=`cat $MODE_FILE`
fi

if [ $monitor_mode = "all" ]; then
        monitor_mode="EXTERNAL"
        xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --auto
elif [ $monitor_mode = "EXTERNAL" ]; then
        monitor_mode="INTERNAL"
        xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --off
elif [ $monitor_mode = "INTERNAL" ]; then
        monitor_mode="CLONES"
        xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --same-as $INTERNAL_OUTPUT
else
        monitor_mode="all"
        xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --left-of $INTERNAL_OUTPUT
fi
echo "${monitor_mode}" > $MODE_FILE
