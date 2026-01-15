#!/usr/bin/env bash

#----------------------------------------------------------
#--  HACK: Lanucher "App launcher"
#----------------------------------------------------------

#  INFO: Styling
STYLE="$HOME/.config/rofi/launcher/style.rasi"

#  INFO: Rofi menu ---
rofi \
    -show drun \
    -theme $STYLE
