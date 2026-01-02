#!/usr/bin/env bash

#----------------------------------------------------------
#--  HACK: Clipboard
#----------------------------------------------------------

# Hyprland rules ---
hyprctl keyword layerrule "animation slide bottom, rofi"

# Style ---
STYLE="$HOME/.config/rofi/calc/calc.rasi"

# Rofu menu ---
rofi -show calc \
    -modi calc \
    -no-show-match \
    -no-sort \
    -calc-command "echo -n '{result}' | wl-copy" \
    -display-calc "🧮" \
    -theme "${STYLE}"

# Resetting layer rules ---
hyprctl keyword layerrule "unset ,rofi"
hyprctl keyword layerrule "blur ,rofi"
hyprctl keyword layerrule "ignorezero ,rofi"
hyprctl keyword layerrule "ignorealpha 0.5,rofi"
