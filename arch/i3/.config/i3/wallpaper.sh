#!/bin/bash
#
# Set random wallpaper for i3. Optionally also renders locker background.
# Dependencies: feh, imagemagick (for lock bg generation)
#
# Rafael Cavalcanti
#

# Define if generates lock background
gen_lock=1

# Wallpaper variables
DIR=$HOME/Imagens/Wallpapers/unsplash
CUR=$HOME/.cache/cur_wallpaper

# Locker variables
LOCK_ICON=$HOME/.config/i3/lock.png
LOCK_BG=$HOME/.cache/lock_bg.png


info() { printf '%s\t%s\n' "$(date)" "$*"; }

log() {
  if [ -n "${WALL_LOG:-}" ]; then
    info >>"$WALL_LOG" "$@"
  else
    info "$@"
  fi
}


set-random() {
	file=`ls $DIR | sort -R | tail -1`
	path="${DIR}/${file}"
	printf "$path" > $CUR
	feh --bg-fill $path
	log "Wallpaper set."

	if [ "$gen_lock" -eq "1" ]; then
		gen-lock "$path"
	fi
}

remove() {
	rm -v "$(cat $CUR)" && notify-send "Wallpaper" "Wallpaper removido."
}

gen-lock() {
	if [[ -f "$LOCK_ICON" ]]; then
		log "Generating session locker background..."
		convert "$1" "$LOCK_ICON" -gravity center -composite -matte "$LOCK_BG"
	else
		log "Couldn't find lock icon. No lock background generated."
	fi
}

usage() {
		cat <<-END >&2
		Usage: $0 <command>
		Commands: set-random, rm.
		END
		exit 1
}

# Check number of args
if [[ $# -ne 1 ]]; then
	usage
fi

case $1 in
	set-random)
		set-random
		;;
	rm)
		remove
		set-random
		;;
	*)
		usage
		;;
esac

