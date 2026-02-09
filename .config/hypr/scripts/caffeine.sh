#!/bin/bash

ICON="/usr/share/icons/Colloid-Yellow-Dark/status/symbolic/budgie-caffeine-cup-full.svg"

if pgrep -x "hypridle" >/dev/null; then
    killall hypridle
    notify-send -i "$ICON" "Caffeine Mode" "Enabled" -a "Caffeine"
else
    hypridle &
    notify-send -i "$ICON" "Caffeine Mode" "Disabled" -a "Caffeine"

fi
