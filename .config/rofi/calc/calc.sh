#!/usr/bin/env bash

#----------------------------------------------------------
#--  HACK: Clipboard
#----------------------------------------------------------

#  INFO: Styling ---
STYLE="$HOME/.config/rofi/calc/calc.rasi"

#  INFO: Rofi menu ---
rofi -show calc \
    -modi calc \
    -no-show-match \
    -no-sort \
    -calc-command "echo -n '{result}' | wl-copy" \
    -display-calc "🧮" \
    -theme "${STYLE}"
