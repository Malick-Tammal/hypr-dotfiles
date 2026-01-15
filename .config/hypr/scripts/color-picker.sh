#!/bin/bash

#----------------------------------------------------------
#--  HACK: Color picker
#----------------------------------------------------------

#  INFO: CONFIGURATION ---
LOGFILE="$HOME/.cache/colorpicker_history.txt"
COLOR_FORMAT="hex" #  TIP: hex or rgb
AUTO_COPY=true
AUTO_PASTE=false
SOUND=true
SOUND_FILE="/usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"
# ---------------------

#  INFO: Getting the color
COLOR=$(hyprpicker)

#  INFO: If selection was cancelled (empty string), exit
if [ -z "$COLOR" ]; then
    exit
fi

#  INFO: Check selected color format
FINAL_COLOR=""

if [ "$COLOR_FORMAT" = "rgb" ]; then
    # Convert hex pairs to decimal
    hex_clean=${COLOR#\#}
    r=$((16#${hex_clean:0:2}))
    g=$((16#${hex_clean:2:2}))
    b=$((16#${hex_clean:4:2}))
    rgb_string="rgb($r, $g, $b)"

    FINAL_COLOR=$rgb_string
else
    FINAL_COLOR=$COLOR
fi

#  INFO: Save to History Log with Timestamp
echo "[$(date +'%Y-%m-%d %H:%M')] => $FINAL_COLOR" >>"$LOGFILE"

#  INFO: Generate rounded box preview image
IMAGE="/tmp/color_preview.png"
if command -v magick &>/dev/null; then
    magick -size 64x64 xc:none -fill "$FINAL_COLOR" -draw "roundrectangle 0,0 63,63 8,8" "$IMAGE"
fi

#  INFO: Play Sound
if "$SOUND"; then
    if command -v paplay &>/dev/null && [ -f "$SOUND_FILE" ]; then
        paplay "$SOUND_FILE" &
    fi
fi

#  INFO: Generating notification
if command -v magick &>/dev/null; then
    #  INFO: Send notification with the color preview
    notify-send -a "Hyprpicker" "Hyprpicker" "$FINAL_COLOR Color Copied" -i "$IMAGE"

    #  INFO: Copy color
    if $AUTO_COPY; then
        wl-copy "$FINAL_COLOR"
    fi

    #  INFO: Paste color
    if "$AUTO_PASTE"; then
        sleep 0.1
        wtype -M ctrl -M shift -k v -m shift -m ctrl
    fi

else
    #  INFO: Fallback if imagemagick isn't installed
    notify-send "Color Copied" "$FINAL_COLOR"
fi
