#!/bin/bash

NEW_THEME=$1
CONFIG_FILE="$HOME/.config/sketchybar/sketchybarrc"

# Use sed to replace the THEME="..." line in the config
# macOS sed requires the empty string argument '' after -i
sed -i '' "s/^THEME=\".*\"/THEME=\"$NEW_THEME\"/" "$CONFIG_FILE"

# Reload SketchyBar (This triggers the reload of jankyborders too!)
sketchybar --reload
