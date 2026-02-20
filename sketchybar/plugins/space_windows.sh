#!/bin/bash
SID=$1

# SOURCE THE SHARED COLORS
source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/plugins/icon_map.sh"

FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
APPS=$(aerospace list-windows --workspace "$SID" --format "%{app-name}")

ICON_STRIP=""
if [ "${APPS}" != "" ]; then
  while read -r app; do
    icon_map "$app"
    ICON_STRIP+="$icon_result "
  done <<< "${APPS}"
fi

# Theme colors (Now pulled from colors.sh)
ACTIVE_BG=$COLOR_ACCENT
ACTIVE_FG=$COLOR_BAR      # Dark text on bright accent
INACTIVE_BG=$COLOR_ITEM_BG
INACTIVE_FG=$COLOR_TEXT
COLOR_BORDER=$COLOR_BORDER

if [ "$SID" == "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME \
        background.drawing=on \
        background.color=$ACTIVE_BG \
        background.border_color=$COLOR_BORDER \
        label.color=$ACTIVE_FG \
        icon.color=$ACTIVE_FG \
        label="$ICON_STRIP"
else
    sketchybar --set $NAME \
        background.drawing=on \
        background.color=$INACTIVE_BG \
        background.border_color=$COLOR_BORDER \
        label.color=$INACTIVE_FG \
        icon.color=$INACTIVE_FG \
        label="$ICON_STRIP"
fi
