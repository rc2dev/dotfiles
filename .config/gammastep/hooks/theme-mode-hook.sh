#!/usr/bin/env bash
#
# Hook to automatically set light/dark themes for day/night.
#
# Copyright (C) 2023 Rafael Cavalcanti <https://rafaelc.org/dev>
# Licensed under GPLv3

set -euo pipefail

notify() {
   notify-send --urgency=low --icon=gammastep "Gammastep" "Theme set to $1."
}

if [[ "$1" != "period-changed" ]]; then
   exit
fi

case "$3" in
    daytime)
       theme-mode light
       notify light
       ;;
    night)
       theme-mode dark
       notify dark
       ;;
    transition)
       if [[ "$(date +%H)" -lt 12 ]]; then
         theme-mode light
         notify light
       else
         theme-mode dark
         notify dark
       fi
       ;;
esac
