#!/usr/bin/env bash
#
# Hook to automatically set light/dark themes for day/night.
#
# Copyright (C) 2023 Rafael Cavalcanti <https://rafaelc.org/dev>
# Licensed under GPLv3

set -euo pipefail

if [[ "$1" != "period-changed" ]]; then
   exit
fi

case "$3" in
    daytime)
       light-dark light
       ;;
    night)
       light-dark dark
       ;;
    transition)
       if [[ "$(date +%H)" -lt 12 ]]; then
         light-dark light
       else
         light-dark dark
       fi
       ;;
esac
