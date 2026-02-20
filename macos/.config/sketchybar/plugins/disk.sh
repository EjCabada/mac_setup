#!/bin/bash

# Get used percentage of the main disk (/)
DISK_PERCENT=$(df -h / | awk 'NR==2 {print $5}')

sketchybar --set $NAME label="$DISK_PERCENT"
