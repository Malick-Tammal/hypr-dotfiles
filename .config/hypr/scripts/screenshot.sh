#!/bin/bash

#----------------------------------------------------------
#--  HACK: Screenshot
#----------------------------------------------------------

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

# Send a notification with the thumbnail of the screenshot
notify_user() {
    notify-send "Screenshot Captured" "Saved to $1" -i "$1" -a "Hyprland"
}

# Send a notification with cancel message
notify_error() {
    notify-send "Screenshot Cancelled" "No selection made" -u low -a "Hyprland"
}

#  INFO: Logic "Options" ---
case "$1" in
--full)
    #  TIP: Fullscreen screenshot
    if $SOUND; then
        # Create the lock file to silence the global notification script
        touch /tmp/silence_notification_sound

        grim "$FILE"
        cat "$FILE" | wl-copy

        notify_user "$FILE"
        paplay "$SOUND_FILE"

        sleep 0.5
        rm /tmp/silence_notification_sound
    else
        grim "$FILE"
        cat "$FILE" | wl-copy

        notify_user "$FILE"
    fi
    ;;

--area)
    #  TIP: Area screenshot
    if $SOUND; then
        # Create the lock file to silence the global notification script
        touch /tmp/silence_notification_sound

        # Select a region
        GEOM=$(slurp)

        # Check if user cancelled (empty geometry)
        if [ -z "$GEOM" ]; then
            notify_error
            exit 1
        fi

        grim -g "$GEOM" "$FILE"
        cat "$FILE" | wl-copy
        notify_user "$FILE"
        paplay "$SOUND_FILE"

        sleep 0.5
        rm /tmp/silence_notification_sound
    else
        # Select a region
        GEOM=$(slurp)

        # Check if user cancelled (empty geometry)
        if [ -z "$GEOM" ]; then
            notify_error
            exit 1
        fi

        grim -g "$GEOM" "$FILE"
        cat "$FILE" | wl-copy
        notify_user "$FILE"
    fi
    ;;
--window)
    #  TIP: Windows selection screenshot
    if $SOUND; then
        # Create the lock file to silence the global notification script
        touch /tmp/silence_notification_sound

        # Pipe all open window positions to slurp
        GEOM=$(hyprctl clients -j | jq -r '.[] | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | slurp)

        if [ -z "$GEOM" ]; then
            notify_error
            exit 1
        fi

        grim -g "$GEOM" "$FILE"
        cat "$FILE" | wl-copy
        notify_user "$FILE"
        paplay "$SOUND_FILE"

        sleep 0.5
        rm /tmp/silence_notification_sound
    else
        # This pipes all open window positions to slurp, allowing you to click one
        GEOM=$(hyprctl clients -j | jq -r '.[] | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | slurp)

        if [ -z "$GEOM" ]; then
            notify_error
            exit 1
        fi

        grim -g "$GEOM" "$FILE"
        cat "$FILE" | wl-copy
        notify_user "$FILE"
    fi

    ;;
--edit)
    #  TIP: Area screenshot with satty editing app
    if $SOUND; then
        # Create the lock file to silence the global notification script
        touch /tmp/silence_notification_sound

        GEOM=$(slurp)
        if [ -z "$GEOM" ]; then
            notify_error
            exit 1
        fi

        paplay "$SOUND_FILE" &
        # Pip the screenshot to satty
        grim -g "$GEOM" - | satty --filename - --output-filename "$FILE"

        sleep 0.5
        rm /tmp/silence_notification_sound
    else
        GEOM=$(slurp)
        if [ -z "$GEOM" ]; then
            notify_error
            exit 1
        fi

        # Pip the screenshot to satty
        grim -g "$GEOM" - | satty --filename - --output-filename "$FILE"
    fi

    ;;
*)
    echo "Usage: $0 {full|area|window|edit}"
    exit 1
    ;;
esac
