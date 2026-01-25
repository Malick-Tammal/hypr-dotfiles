#!/bin/bash

#----------------------------------------------------------
#--  HACK: Swayosd + sounds
#----------------------------------------------------------

#  INFO: CONFIGURATION ---
VOL_SOUND="/usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"
MUTE_SOUND="/usr/share/sounds/freedesktop/stereo/device-removed.oga"
# -----------------------

#  INFO: Play sound cleanly
play_sound() {
    local file=$1
    pkill -f "paplay $file"
    paplay "$file" &
}

#  INFO: Swayosd options
case "$1" in
--audio-inc)
    swayosd-client --output-volume raise --max-volume 100
    # play_sound "$VOL_SOUND"
    ;;
--audio-dec)
    swayosd-client --output-volume lower --max-volume 100
    # play_sound "$VOL_SOUND"
    ;;
--mute)
    swayosd-client --output-volume mute-toggle
    play_sound "$MUTE_SOUND"
    ;;
--mute-mic)
    swayosd-client --input-volume mute-toggle
    play_sound "$MUTE_SOUND"
    ;;
--display-inc)
    swayosd-client --brightness +10
    # play_sound "$VOL_SOUND"
    ;;
--display-dec)
    swayosd-client --brightness -10
    # play_sound "$VOL_SOUND"
    ;;
esac
