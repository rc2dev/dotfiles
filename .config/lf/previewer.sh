#!/usr/bin/env bash
#
# Based on <https://github.com/gokcehan/lf/issues/904#issuecomment-1331826453>
# by Rafael Cavalcanti <https://rafaelc.org/dev>.

MIME=$(mimetype --all --brief "$1")
PREVIEWER_IMG="$HOME/.config/lf/previewer_img/previewer_img.sh"

case "$MIME" in
    # .pdf
    *application/pdf*)
        $PREVIEWER_IMG "$@"
        # Alternatively, just text: pdftotext "$1" -
        ;;
    # .7z
    *application/x-7z-compressed*)
        7z l "$1"
        ;;
    # .tar .tar.Z
    *application/x-tar*)
        tar -tvf "$1"
        ;;
    # .tar.*
    *application/x-compressed-tar*|*application/x-*-compressed-tar*)
        tar -tvf "$1"
        ;;
    # .rar
    *application/vnd.rar*)
        unrar l "$1"
        ;;
    # .zip
    *application/zip*)
        unzip -l "$1"
        ;;
    # any plain text file that doesn't have a specific handler
    *text/plain*)
        # return false to always repaint, in case terminal size changes
        batcat --color always --decorations never "$1" && false
        ;;
    *image/*)
        "$PREVIEWER_IMG" "$@"
        ;;
    *video/*)
        "$PREVIEWER_IMG" "$@"
        ;;
    *)
        echo "No preview for this format."
        ;;
esac
