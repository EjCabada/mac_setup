#!/bin/bash
# Get CPU usage (sum of all cores)
CPU_USAGE=$(ps -A -o %cpu | awk '{s+=$1} END {print s}' | cut -d. -f1)

# Cap at 99% for cleaner look
if [ "$CPU_USAGE" -gt 99 ]; then CPU_USAGE=99; fi

sketchybar --set $NAME label="${CPU_USAGE}%"
