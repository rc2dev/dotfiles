#!/usr/bin/env bash
#
# Lock screen on i3. Called by xautolock when idle.
# Dependencies: playerctl, xprop, i3lock
#
# Rafael Cavalcanti
#

export LOCK_BG=$HOME/.cache/lock_bg.png


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

lock() {
	log "Telling dunst to queue notifications..."
	killall -USR1 dunst

	if [[ -f "$LOCK_BG" ]]; then
		local param="-i $LOCK_BG"
	else
		log "Background not found. Using solid color."
		local param="-c 2f343f"
	fi

	log "Calling i3lock..."
	i3lock --nofork $param &

	log "Waiting for unlock..."
	wait

	log "Resuming dunst..."
	killall -USR2 dunst
}

susp() {
	systemctl suspend
}

usage() {
	cat <<-EOF
	Usage: $(basename "$0") [options] command

	Commands:
	  -l: lock
	  -s: suspend
	Options:
	  -n: now (ignore inhibitors)
	EOF
	exit 0
}

check_argc() {
	if [[ $# < 1 || $# > 2 ]]; then
		printf "Wrong number of arguments.\n"
		usage
	fi
}


check_argc "$@"

# Get options
now=0
lock=0
susp=0
while getopts "nls" opt; do
	echo $opt
	case $opt in
		n) now=1 ;;
		l) lock=1 ;;
		s) susp=1 ;;
	esac
done

# Argument error
[[ $lock == $susp ]] && usage

# Check fullscreen if not "now"
# Pause song if "now"
[[ $now != 1 ]] && check_fullscreen || playerctl pause

# Execute command
[[ $lock == 1 ]]  && lock
[[ $susp == 1 ]]  && susp

