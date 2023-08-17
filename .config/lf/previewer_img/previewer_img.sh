#!/bin/sh
# Needed for image preview with ueberzug.
# Based on <https://github.com/gokcehan/lf/wiki/Previews>.

draw() {
  ~/.config/lf/previewer_img/draw_img.sh "$@"
  exit 1
}

hash() {
  printf '%s/.cache/lf/%s' "$HOME" \
    "$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | awk '{print $1}')"
}

cache() {
  if [ -f "$1" ]; then
    draw "$@"
  fi
}

file="$1"
shift

if [ -n "$FIFO_UEBERZUG" ]; then
  case "$(mimetype --all --brief "$file")" in
    *image/*)
      orientation="$(identify -format '%[EXIF:Orientation]\n' -- "$file")"
      if [ -n "$orientation" ] && [ "$orientation" != 1 ]; then
        cache="$(hash "$file").jpg"
        cache "$cache" "$@"
        convert -- "$file" -auto-orient "$cache"
        draw "$cache" "$@"
      else
        draw "$file" "$@"
      fi
      ;;

    *video/*)
      cache="$(hash "$file").jpg"
      cache "$cache" "$@"
      ffmpegthumbnailer -i "$file" -o "$cache" -s 0
      draw "$cache" "$@"
      ;;

    *application/pdf*)
      cache="$(hash "$file").jpg"
      cache "$cache" "$@"
      gs -o "$cache" -sDEVICE=pngalpha -dLastPage=1 "$file" > /dev/null
      draw "$cache" "$@"
      ;;

    *application/vnd.oasis.opendocument.*)
      cache="$(hash "$file").jpg"
      cache "$cache" "$@"
      libreoffice --convert-to png --outdir /tmp "$file" > /dev/null
      mv "/tmp/$(basename "${file%.*}").png" "$cache"
      draw "$cache" "$@"
      ;;
  esac
fi

file -Lb -- "$1" | fold -s -w "$width"
exit 0
