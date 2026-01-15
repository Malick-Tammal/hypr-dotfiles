#!/bin/bash

#----------------------------------------------------------
#--  HACK: Keyboard language switcher
#----------------------------------------------------------

#  INFO: Switch layout for ALL keyboards to keep them in sync
hyprctl switchxkblayout all next

#  INFO: Get the full active keymap name
FULL_LAYOUT=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap' | head -n1)

#  INFO: SwayOSD Display
# Check if the swayosd-server is running before sending the command
if pgrep -x "swayosd-server" >/dev/null; then
    swayosd-client --custom-message "$FULL_LAYOUT" --custom-icon "input-keyboard"
else
    # Fallback to a standard notification if the OSD server is down
    notify-send "Keyboard Layout" "$FULL_LAYOUT" -i input-keyboard
fi
