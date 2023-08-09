#!/bin/sh
# Needed for image preview with ueberzug.
# Copied from <https://github.com/gokcehan/lf/wiki/Previews>.

if [ -n "$FIFO_UEBERZUG" ]; then
  printf '{"action": "remove", "identifier": "preview"}\n' >"$FIFO_UEBERZUG"
fi
