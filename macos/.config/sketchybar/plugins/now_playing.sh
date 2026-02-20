#!/bin/bash

# Check if media is playing via system metadata
PLAYER_INFO=$(
  osascript -e '
    try
      set output to ""
      if application "Music" is running then
        tell application "Music"
          if player state is playing then
            set output to artist of current track & " - " & name of current track
          end if
        end tell
      end if
      if output is "" and application "Spotify" is running then
        tell application "Spotify"
          if player state is playing then
            set output to artist of current track & " - " & name of current track
          end if
        end tell
      end if
      return output
    on error
      return ""
    end try
  '
)

if [[ -z "$PLAYER_INFO" ]]; then
    # Nothing playing: hide the item
    sketchybar --set $NAME drawing=off
else
    # Truncate label for the bar
    TRUNCATED_LABEL=$(echo "$PLAYER_INFO" | awk '{
      if (length($0) > 40) {
        print substr($0, 1, 37) "..."
      } else {
        print $0
      }
    }')

    # Show item
    sketchybar --set $NAME \
               drawing=on \
               icon="" \
               label="$TRUNCATED_LABEL"
fi