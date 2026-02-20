#!/bin/bash

# Use ipconfig to get the SSID directly (more reliable on modern macOS)
SSID=$(ipconfig getsummary en0 | awk -F ' SSID : ' '/ SSID : / {print $2}')

# If en0 is empty, try en1 (standard for some Mac models)
if [ -z "$SSID" ]; then
    SSID=$(ipconfig getsummary en1 | awk -F ' SSID : ' '/ SSID : / {print $2}')
fi

if [ -z "$SSID" ]; then
    SSID="Disconnected"
    ICON="󰤮"
else
    # Truncate long SSIDs for bar space
    if [ ${#SSID} -gt 15 ]; then
      SSID="${SSID:0:12}..."
    fi
    ICON=""
fi

sketchybar --set $NAME label="$SSID" icon="$ICON"
