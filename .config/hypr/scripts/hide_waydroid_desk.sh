#!/usr/bin/env bash

APP_DIR="$HOME/.local/share/applications"

shopt -s nullglob
files=("$APP_DIR"/waydroid.*.desktop)

if [ ${#files[@]} -eq 0 ]; then
    echo "No Waydroid app entries found in $APP_DIR."
    exit 0
fi

echo "Hiding ${#files[@]} Waydroid app entries..."

for file in "${files[@]}"; do
    sed -i '/^NoDisplay=/d' "$file"
    sed -i '/^\[Desktop Entry\]/a NoDisplay=true' "$file"
    echo "  [+] Processed: $(basename "$file")"
done

rm -f ~/.cache/rofi*.cache

echo "Done! Waydroid entries are hidden and Rofi cache cleared."
