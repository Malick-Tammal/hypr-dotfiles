#!/bin/bash

#----------------------------------------------------------
#--  HACK: Caffeine (Wayland Inhibitor)
#----------------------------------------------------------

ICON="/usr/share/icons/Colloid-Yellow-Dark/status/symbolic/budgie-caffeine-cup-full.svg"

if pgrep -x "wayland-idle-inhibitor" >/dev/null || pgrep -x "wayland-idle-in" >/dev/null; then
    killall wayland-idle-inhibitor
    notify-send -i "$ICON" "Caffeine Mode" "Disabled" -a "Caffeine"
else
    wayland-idle-inhibitor &
    notify-send -i "$ICON" "Caffeine Mode" "Enabled" -a "Caffeine"
fi
