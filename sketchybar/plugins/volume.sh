#!/bin/bash

# Get Volume
VOL=$(osascript -e 'output volume of (get volume settings)')
MUTED=$(osascript -e 'output muted of (get volume settings)')

if [ "$MUTED" != "false" ]; then
  ICON=""
  VOL="Mute"
else
  case ${VOL} in
    100) ICON="";;
    [5-9][0-9]) ICON="";;
    [2-4][0-9]) ICON="";;
    [0-1][0-9]) ICON="";;
    *) ICON="";;
  esac
fi

sketchybar --set $NAME icon="$ICON" label="$VOL%"
