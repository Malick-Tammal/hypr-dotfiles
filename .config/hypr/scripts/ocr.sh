#!/usr/bin/env bash

#----------------------------------------------------------
#--  HACK: OCR
#----------------------------------------------------------

#  INFO: Temp file
TMP_IMG="/tmp/ocr_snap.png"

# Capture the screenshot
grim -g "$(slurp -d)" "$TMP_IMG" || exit 1

# Pre-process the image for better accuracy
magick "$TMP_IMG" -modulate 100,0 -resize 200% -units PixelsPerInch -density 300 "$TMP_IMG"

# Run Tesseract with (English, French, Arabic)
TEXT=$(tesseract "$TMP_IMG" stdout -l eng+fra+ara 2>/dev/null)

# Cleanup the text
CLEAN_TEXT=$(echo "$TEXT" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

#  INFO: Output
if [ -n "$CLEAN_TEXT" ]; then
    echo "$CLEAN_TEXT" | wl-copy
    notify-send -u low -i tv "OCR" "$(echo "$CLEAN_TEXT" | head -c 100)..." -a "OCR"
else
    notify-send -u low -i tv "OCR" "No text detected." -a "OCR"
fi

#  INFO: Cleanup
rm "$TMP_IMG"
