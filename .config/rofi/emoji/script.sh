#!/usr/bin/env bash

#----------------------------------------------------------
#--  HACK: Emoji picker
#----------------------------------------------------------

#  INFO: Styling ---
STYLE="$HOME/.config/rofi/emoji/style.rasi"

#  INFO: Rofi menu ---
rofi \
    -modi emoji \
    -show emoji \
    -display-emoji "⚡" \
    -theme $STYLE
