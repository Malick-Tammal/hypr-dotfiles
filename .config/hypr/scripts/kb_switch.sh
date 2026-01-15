#!/bin/bash

#----------------------------------------------------------
#--  HACK: Keyboard language switcher
#----------------------------------------------------------

#  INFO: Sound file
SOUND="/usr/share/sounds/freedesktop/stereo/dialog-warning.oga"

#  INFO: Switch layout for ALL keyboards to keep them in sync
hyprctl switchxkblayout all next

#  INFO: Play sound
play_sound() {
    local file=$1
    pkill -f "paplay $file"
    paplay "$file" &
}

#  INFO: Get the full active keymap name
FULL_LAYOUT=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap' | head -n1)

#  INFO: SwayOSD Display
# Check if the swayosd-server is running before sending the command
if pgrep -x "swayosd-server" >/dev/null; then
    swayosd-client --custom-message "$FULL_LAYOUT" --custom-icon "input-keyboard"
    play_sound "$SOUND"
else
    # Fallback to a standard notification if the OSD server is down
    notify-send "Keyboard Layout" "$FULL_LAYOUT" -i input-keyboard
    play_sound "$SOUND"
fi
