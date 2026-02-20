#!/bin/bash

# Source exported colors from main config
source "$HOME/.config/sketchybar/colors.sh"

# Check DND Status
STATUS=$(defaults read com.apple.controlcenter "NCBlockAll" 2>/dev/null)

# Define dynamic colors based on DND status
if [ "$STATUS" = "1" ]; then
    ICON="" # Bell Slash (DND ON)
    BG_COLOR=$COLOR_ACCENT 
    ICON_COLOR=$COLOR_BAR # Assuming dark background color for contrasting text on ACCENT
else
    ICON="" # Bell (DND OFF)
    BG_COLOR=$COLOR_ITEM_BG 
    ICON_COLOR=$COLOR_TEXT
fi

# Explicitly setting all colors here for reliability
sketchybar --set $NAME icon="$ICON" background.color=$BG_COLOR icon.color=$ICON_COLOR