#!/bin/bash
#----------------------------------------------------------
#--  HACK: Walli "Wallpaper switcher"
#----------------------------------------------------------

#  INFO: Configuration ---
WALLS_DIR="$HOME/Pictures/Wallpapers/"
CACHE_DIR="$HOME/.cache/wallpaper_thumbs"
STYLE="$HOME/.config/rofi/walli/style.rasi"
ANIM_TYPE="wave" #  TIP: Options => simple | fade | left | right | top | bottom | wipe | grow | center | outer | random | wave

#  INFO: Cache ---
mkdir -p "$CACHE_DIR"

#  INFO: Background Thumbnailer ---
generate_thumbs() {
    find "$WALLS_DIR" -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" \) -print0 |
        while IFS= read -r -d '' img; do
            name=$(basename "$img")
            thumb="$CACHE_DIR/${name}.png"

            # Only generate if missing
            if [ ! -f "$thumb" ]; then
                nice -n 19 magick "${img}[0]" -strip -scale 400x450^ -gravity center -extent 400x450 "$thumb"
            fi
        done
}

#  INFO: Start generation in background ---
generate_thumbs &

#  INFO: Rofi Menu ---
SELECTED_NAME=$(
    find "$WALLS_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | sort | while read -r img; do
        name=$(basename "$img")
        thumb="$CACHE_DIR/${name}.png"
        echo -en "${name}\0icon\x1f${thumb}\n"
    done | rofi -dmenu -theme "$STYLE"
)

#  INFO: Select event ---
if [ -n "$SELECTED_NAME" ]; then
    FULL_PATH="$WALLS_DIR/$SELECTED_NAME"

    if [ -f "$FULL_PATH" ]; then
        if ! pgrep -x "swww-daemon" >/dev/null; then
            swww-daemon &
            sleep 0.5
        fi

        # Set wallpaper
        swww img "$FULL_PATH" --transition-type "$ANIM_TYPE" --transition-step 90 --transition-fps 60 &

        # Cache it for others
        cp $FULL_PATH "$HOME/.cache/current-wallpaper.png" &

        # Copy for sddm
        cp $FULL_PATH "/usr/share/sddm/themes/sddm-modern/wallpaper.png" &

        # Notify user
        notify-send -a "Walli" "Walli" "$SELECTED_NAME" &
    else
        notify-send -a "Walli" "Error" "File not found: $SELECTED_NAME"
    fi
fi
