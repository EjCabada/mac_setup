#!/bin/bash
# Check if the main display is the built-in laptop screen
MAIN_DISPLAY=$(system_profiler SPDisplaysDataType | grep -B 3 'Main Display: Yes' | grep 'Display Type')

if [[ "$MAIN_DISPLAY" == *"Built-in"* ]]; then
  # Laptop: reserve space for notch
  sketchybar --bar notch_width=188
else
  # External Monitor: remove notch reservation
  sketchybar --bar notch_width=0
fi
