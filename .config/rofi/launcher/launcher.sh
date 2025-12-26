#!/usr/bin/env bash

#----------------------------------------------------------
#--  HACK: Lanucher "App launcher"
#----------------------------------------------------------

# Hyprland rules ---
hyprctl keyword layerrule "animation slide bottom, rofi"

# Style ---
STYLE="$HOME/.config/rofi/launcher/launcher.rasi"

# Rofu menu ---
rofi \
    -show drun \
    -theme $STYLE

# Resetting layer rules ---
hyprctl keyword layerrule "unset ,rofi"
hyprctl keyword layerrule "blur ,rofi"
hyprctl keyword layerrule "ignorezero ,rofi"
hyprctl keyword layerrule "ignorealpha 0.5,rofi"
