#!/bin/bash
#----------------------------------------------------------
#--  HACK: Walli "Wallpaper switcher"
#----------------------------------------------------------

# Hyprland rules
hyprctl keyword layerrule "animation slide top, rofi"
hyprctl keyword layerrule "dimaround ,rofi"

# --- Configuration ---
WALLS_DIR="$HOME/Pictures/Wallpapers/Monokai/"
CACHE_DIR="$HOME/.cache/wallpaper_thumbs"
STYLE="$HOME/.config/rofi/walli/walli.rasi"
ANIM_TYPE="grow" #  TIP: Options => simple | fade | left | right | top | bottom | wipe | grow | center | outer | random | wave

# Ensure directories exist
mkdir -p "$CACHE_DIR"

# Background Thumbnailer
generate_thumbs() {
    find "$WALLS_DIR" -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) -print0 |
        while IFS= read -r -d '' img; do
            name=$(basename "$img")
            thumb="$CACHE_DIR/${name}.png"

            # Only generate if missing
            if [ ! -f "$thumb" ]; then
                nice -n 19 magick "$img" -strip -scale 400x450^ -gravity center -extent 400x450 "$thumb"
            fi
        done
}

# Start generation in background
generate_thumbs &

# Rofi Menu
SELECTED_NAME=$(
    find "$WALLS_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort | while read -r img; do
        name=$(basename "$img")
        thumb="$CACHE_DIR/${name}.png"
        echo -en "${name}\0icon\x1f${thumb}\n"
    done | rofi -dmenu -class "walli" -i -p "Wallpapers" -theme "$STYLE"
)

# Action
if [ -n "$SELECTED_NAME" ]; then
    FULL_PATH="$WALLS_DIR/$SELECTED_NAME"

    if [ -f "$FULL_PATH" ]; then
        if ! pgrep -x "swww-daemon" >/dev/null; then
            swww-daemon &
            sleep 0.5
        fi

        # Set wallpaper
        swww img "$FULL_PATH" --transition-type "$ANIM_TYPE" --transition-step 90 --transition-fps 60 &

        # Notify user
        notify-send -a "Walli" "Walli" "$SELECTED_NAME" &
    else
        notify-send -a "Walli" "Error" "File not found: $SELECTED_NAME"
    fi
fi

# Reseting layer rules
hyprctl keyword layerrule "unset ,rofi"
hyprctl keyword layerrule "blur ,rofi"
hyprctl keyword layerrule "ignorezero ,rofi"
hyprctl keyword layerrule "ignorealpha 0.5,rofi"
