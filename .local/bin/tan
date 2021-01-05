#!/bin/sh
#
# twan.sh
# Copyright (C) 2016 djp <djp@cutter>
#
# Distributed under terms of the MIT license.
#

ID=$*
if ! echo "$ID" | grep -q '[0-9]\+'; then
    echo "  ERROR: twan command must be followed by a single task ID"
    exit 1
fi
FILE="`mktemp`"
EDITOR="${EDITOR:-vi}"
$EDITOR "$FILE"
task $ID annotate "`echo -n "\n"; cat $FILE`"
rm "$FILE"
exit 0

