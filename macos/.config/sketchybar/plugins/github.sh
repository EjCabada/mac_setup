#!/bin/bash

# Check notifications using GitHub CLI
NOTIFICATIONS="$(gh api notifications --q 'length')"

if [ "$NOTIFICATIONS" = "" ]; then
  NOTIFICATIONS="0"
fi

sketchybar --set $NAME label="$NOTIFICATIONS"
