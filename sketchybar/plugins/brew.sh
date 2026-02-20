#!/bin/bash

# Source your colors so we can use $COLOR_TEXT
source "$HOME/.config/sketchybar/colors.sh"

# Count outdated packages
OUTDATED=$(brew outdated | wc -l | tr -d ' ')

if [ "$OUTDATED" != "0" ]; then
  # Use white text ($COLOR_TEXT) on the Red background
  COLOR=$COLOR_TEXT 
else
  COLOR=$COLOR_TEXT
fi

sketchybar --set $NAME label="$OUTDATED" icon.color=$COLOR label.color=$COLOR