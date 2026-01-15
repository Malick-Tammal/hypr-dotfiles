#!/bin/bash

#----------------------------------------------------------
#--  HACK: Charger monitor
#----------------------------------------------------------

#  INFO: CONFIGURATION ---
SOUND_PLUG="/usr/share/sounds/freedesktop/stereo/power-plug.oga"
SOUND_UNPLUG="/usr/share/sounds/freedesktop/stereo/power-unplug.oga"
# ------------------------

#  INFO: Find the AC Adapter
AC_FILE=""
for supply in /sys/class/power_supply/*; do
    if [ -f "$supply/type" ] && grep -q "Mains" "$supply/type"; then
        AC_FILE="$supply/online"
        break
    fi
done

#  INFO: Error handler
if [ -z "$AC_FILE" ]; then
    notify-send "Error" "Could not find AC Adapter."
    exit 1
fi

last_state=$(cat "$AC_FILE")

while true; do
    current_state=$(cat "$AC_FILE")

    if [ "$current_state" != "$last_state" ]; then

        #  INFO: Create the lock file to silence the global notification script
        touch /tmp/silence_notification_sound

        if [ "$current_state" == "1" ]; then
            paplay "$SOUND_PLUG"
            notify-send -a "Power" "Power" "Charger Connected"
        else
            paplay "$SOUND_UNPLUG"
            notify-send -a "Power" "Power" "Charger Disconnected"
        fi

        #  INFO:  Wait a split second and remove the lock file
        sleep 0.5
        rm /tmp/silence_notification_sound

        last_state=$current_state
    fi
done
