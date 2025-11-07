#!/usr/bin/env bash
#
# Based on <https://github.com/gokcehan/lf/issues/904#issuecomment-1331826453>
# by Rafael Cavalcanti <https://rafaelc.org/dev>.

MIME=$(mimetype --all --brief "$1")

case "$MIME" in
    # .pdf
    *application/pdf*)
        pdftotext "$1" -
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
    *audio/*)
        mediainfo "$1" | sed -E 's/\s+\:/:/' | column --separator=':' --table --keep-empty-lines | grep -v '^Complete name'
        ;;
    # any plain text file that doesn't have a specific handler
    *text/plain*)
        # return false to always repaint, in case terminal size changes
        ${BAT_CMD:-bat} --color always --decorations never "$1" && false
        ;;
    *)
        echo "No preview for this format."
        ;;
esac
