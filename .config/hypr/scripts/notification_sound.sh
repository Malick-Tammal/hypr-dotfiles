#!/bin/bash

#----------------------------------------------------------
#--  HACK: Notification sound
#----------------------------------------------------------

#  INFO: Sound file
SOUND="/usr/share/sounds/freedesktop/stereo/bell.oga"

#  INFO: Listen to the DBus for notification requests
dbus-monitor "interface='org.freedesktop.Notifications', member='Notify'" 2>/dev/null |
    grep --line-buffered "member=Notify" |
    while read -r line; do

        #  INFO: Play sound in background
        # Only play if the silence file does NOT exist
        if [ ! -f "/tmp/silence_notification_sound" ]; then
            if [ -f "$SOUND" ]; then
                paplay "$SOUND" &
            fi
        fi
    done
