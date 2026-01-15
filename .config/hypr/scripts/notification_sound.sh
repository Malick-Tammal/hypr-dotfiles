#!/bin/bash

#----------------------------------------------------------
#--  HACK: Notification sound
#----------------------------------------------------------

#  INFO: Sound file
SOUND="/usr/share/sounds/freedesktop/stereo/message.oga"

#  INFO: Listen to the DBus for notification requests
dbus-monitor "interface='org.freedesktop.Notifications', member='Notify'" 2>/dev/null |
    grep --line-buffered "member=Notify" |
    while read -r line; do

        #  INFO: Play sound in background
        if [ -f "$SOUND" ]; then
            paplay "$SOUND" &
        fi
    done
