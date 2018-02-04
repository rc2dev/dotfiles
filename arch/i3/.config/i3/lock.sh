#!/usr/bin/env bash
#
# Lock screen on i3. Called by xautolock when idle.
# Dependencies: playerctl, xprop, i3lock
#
# Rafael Cavalcanti
#

LOCK_BG=$HOME/.cache/lock_bg.png


info() { printf '%s\t%s\n' "$(date)" "$*"; }

log() {
  if [ -n "${LOCK_LOG:-}" ]; then
    info >>"$LOCK_LOG" "$@"
  else
    info "$@"
  fi
}

# An attempt to detect full screen videos. Detects every full screen window.
check_fullscreen() {
	xprop -id `xprop -root 32x '\t$0' _NET_ACTIVE_WINDOW | cut -f 2` | grep -q _NET_WM_STATE_FULLSCREEN
	if [[ $? == 0 ]]; then
		log "Focused window is fullscreen. Halting..."
		exit 0
	fi
	log "Didn't detect current window as fullscreen. Going on..."
}

usage() {
	printf "$0 [--now]\n"
	printf "\t--now: lock now, ignoring inhibitors\n"
	exit 0
}

check_args() {
	if [[ $# > 1 || ( $# == 1 && "$1" != "--now") ]]; then
		usage
	fi
}


check_args "$@"

if [[ "$1" != "--now" ]]; then
	check_fullscreen
fi

log "Telling dunst to queue notifications..."
killall -USR1 dunst

if [[ -f "$LOCK_BG" ]]; then
	param="-i $LOCK_BG"
else
	log "Background not found. Using solid color."
	param="-c 2f343f"
fi

log "Calling i3lock..."
i3lock --nofork $param &

log "Waiting for unlock..."
wait

log "Resuming dunst..."
killall -USR2 dunst

