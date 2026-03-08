#!/bin/bash

#----------------------------------------------------------
#--  HACK: Screenshot
#----------------------------------------------------------

#  INFO: Prevent spam
if pgrep -x "slurp" >/dev/null; then
    exit 0
fi

#  INFO: CONFIGURATION ---
DIR="$HOME/Pictures/Screenshots"
NAME="Screenshot_$(date +'%Y%m%d_%H%M%S').png"
FILE="$DIR/$NAME"
SOUND=true
SOUND_FILE="/usr/share/sounds/freedesktop/stereo/screen-capture.oga"
# -----------------------

#  INFO: Ensure the directory exists ---
mkdir -p "$DIR"

#  INFO: Notification ---

notify_user() {
    if $SOUND; then
        touch /tmp/silence_notification_sound

        notify-send "Screenshot Captured" "Saved to $1" -i "$1" -a "Hyprland"
        paplay "$SOUND_FILE" &

        (
            sleep 0.5
            rm -f /tmp/silence_notification_sound
        ) &
    else
        notify-send "Screenshot Captured" "Saved to $1" -i "$1" -a "Hyprland"
    fi
}

notify_error() {
    notify-send "Screenshot Cancelled" "No selection made" -u low -a "Hyprland"
}

#  INFO: Logic "Options" ---
case "$1" in
--full)
    #  TIP: Fullscreen screenshot
    grim "$FILE"
    wl-copy <"$FILE"
    notify_user "$FILE"
    ;;

--area)
    #  TIP: Area screenshot
    GEOM=$(slurp)

    if [ -z "$GEOM" ]; then
        notify_error
        exit 1
    fi

    grim -g "$GEOM" "$FILE"
    wl-copy <"$FILE"
    notify_user "$FILE"
    ;;

--window)
    #  TIP: Windows selection screenshot (Current workspace only, ignores scratchpads)
    ACTIVE_WS=$(hyprctl activeworkspace -j | jq '.id')

    GEOM=$(hyprctl clients -j | jq -r --argjson active_ws "$ACTIVE_WS" '.[] | select(.workspace.id == $active_ws and .hidden == false) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | slurp)

    if [ -z "$GEOM" ]; then
        notify_error
        exit 1
    fi

    grim -g "$GEOM" "$FILE"
    wl-copy <"$FILE"
    notify_user "$FILE"
    ;;

--edit)
    #  TIP: Area screenshot with satty editing app
    GEOM=$(slurp)
    if [ -z "$GEOM" ]; then
        notify_error
        exit 1
    fi

    if $SOUND; then
        touch /tmp/silence_notification_sound
        paplay "$SOUND_FILE" &
        (
            sleep 0.5
            rm -f /tmp/silence_notification_sound
        ) &
    fi

    # Pip the screenshot to satty
    grim -g "$GEOM" - | satty --filename - --output-filename "$FILE"
    ;;

*)
    echo "Usage: $0 {--full|--area|--window|--edit}"
    exit 1
    ;;
esac
