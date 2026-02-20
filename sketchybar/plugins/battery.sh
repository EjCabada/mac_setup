#!/bin/bash
# Get battery percentage and charging status
# Extract percentage (removes the semicolon)
PERCENTAGE=$(pmset -g batt | grep -oE '[0-9]+%' | head -1 | tr -d '%' | tr -d '\n')
STATUS=$(pmset -g batt | awk '/[0-9]%/{print $4}' | tr -d ',')

# Icon based on status
if [[ "$STATUS" == "charging" ]] || [[ "$STATUS" == "charged" ]]; then
    ICON="" # Lightning bolt (nf-fa-flash)
else
    # Icon based on percentage (nf-fa-battery family)
    case ${PERCENTAGE} in
        100) ICON="";; # Full
        9[0-9]) ICON="";;
        [6-8][0-9]) ICON="";; # 3/4
        [3-5][0-9]) ICON="";; # 1/2
        [1-2][0-9]) ICON="";; # 1/4
        *) ICON="";; # Low/Empty
    esac
fi

# Set the item
sketchybar --set $NAME icon="$ICON" label="${PERCENTAGE}%"