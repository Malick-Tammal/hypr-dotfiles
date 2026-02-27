#!/bin/bash

#----------------------------------------------------------
#--  HACK: Charger monitor (Udev Event Driven)
#----------------------------------------------------------

#  INFO: CONFIGURATION ---
SOUND=true
SOUND_PLUG="/usr/share/sounds/freedesktop/stereo/window-question.oga"
SOUND_UNPLUG="/usr/share/sounds/freedesktop/stereo/window-attention.oga"
# ------------------------

#  INFO: Find the AC Adapter ---
AC_FILE=""
for supply in /sys/class/power_supply/*; do
    if [ -f "$supply/type" ] && grep -q "Mains" "$supply/type"; then
        AC_FILE="$supply/online"
        break
    fi
done

#  INFO: Error handler ---
if [ -z "$AC_FILE" ]; then
    notify-send "Error" "Could not find AC Adapter." -a "Hyprland"
    exit 1
fi

last_state=$(cat "$AC_FILE")

#  INFO: Main logic function
check_charger() {
    local current_state=$(cat "$AC_FILE")

    if [ "$current_state" != "$last_state" ]; then
        if "$SOUND"; then
            touch /tmp/silence_notification_sound

            if [ "$current_state" == "1" ]; then
                paplay "$SOUND_PLUG" &
                notify-send -a "Power" "Power" "Charger Connected" -a "Hyprland"
            else
                paplay "$SOUND_UNPLUG" &
                notify-send -a "Power" "Power" "Charger Disconnected" -a "Hyprland"
            fi

            sleep 0.5
            rm -f /tmp/silence_notification_sound
        else
            if [ "$current_state" == "1" ]; then
                notify-send -a "Power" "Power" "Charger Connected" -a "Hyprland"
            else
                notify-send -a "Power" "Power" "Charger Disconnected" -a "Hyprland"
            fi
        fi

        last_state=$current_state
    fi
}

#  INFO: Event Listener
udevadm monitor --subsystem-match=power_supply | grep --line-buffered "change" | while read -r; do
    check_charger
done
