#!/bin/bash

#----------------------------------------------------------
#--  HACK: Power profiles
#----------------------------------------------------------

#  INFO: Styling ---
STYLE="$HOME/.config/rofi/powerprofiles/style.rasi"

#  INFO: Define profiles ---
PERF="Performance"
BAL="Balanced"
SAVER="Power Saver"

#  INFO: Get the current power profile
CURRENT=$(powerprofilesctl get)

case "$CURRENT" in
"performance")
    active_row=0
    ;;
"balanced")
    active_row=1
    ;;
"power-saver")
    active_row=2
    ;;
*)
    active_row=1 # Default fallback
    ;;
esac

OPTIONS="$PERF\n$BAL\n$SAVER"

#  INFO: Rofi menu ---
run_rofi() {
    echo -e "$OPTIONS" | rofi -dmenu \
        -theme "$STYLE" \
        -selected-row ${active_row} \
        -p "Power"
}

#  INFO: Selected ---
SELECTED="$(run_rofi)"

#  INFO: Setting power plan ---
case ${SELECTED} in
"Performance")
    echo "Setting Performance plan"
    powerprofilesctl set performance
    notify-send "⚡  Performance" "Switched to High Performance" -a "Hyprland"
    ;;

"Balanced")
    echo "Setting Balanced plan"
    powerprofilesctl set balanced
    notify-send "⚖️  Balanced" "Switched to Balanced Mode" -a "Hyprland"
    ;;

"Power Saver")
    echo "Setting Powersaver plan"
    powerprofilesctl set power-saver
    notify-send "🪫 Power Saver" "Switched to Power Saver Mode" -a "Hyprland"
    ;;
esac
