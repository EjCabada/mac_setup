#!/bin/bash

# $INFO contains the app name when triggered by front_app_switched
APP_NAME="$INFO"

# Clean up app name if it's empty (initial load)
if [ -z "$APP_NAME" ]; then
    APP_NAME=$(aerospace list-windows --focused --format "%{app-name}")
fi

sketchybar --set $NAME label="$APP_NAME"
