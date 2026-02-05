#!/usr/bin/env bash

#----------------------------------------------------------
#--  HACK: Touchpad
#----------------------------------------------------------

#  INFO: Device name
DEVICE="dell08b8:00-0488:121f-touchpad"

#  INFO: Statue file
STATUS_FILE="/run/user/$(id -u)/touchpad.status"

if [ -f "$STATUS_FILE" ]; then
    # Toggle ON
    notify-send -u low -i input-touchpad-on "Touchpad" "Enabled"
    hyprctl keyword "device[$DEVICE]:enabled" true
    rm "$STATUS_FILE"
else
    # Toggle OFF
    notify-send -u low -i input-touchpad-off "Touchpad" "Disabled"
    hyprctl keyword "device[$DEVICE]:enabled" false
    touch "$STATUS_FILE"
fi
