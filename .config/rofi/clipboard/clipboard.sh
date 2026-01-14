#!/usr/bin/env bash

#----------------------------------------------------------
#--  HACK: Clipboard
#----------------------------------------------------------

#  INFO: Styling ---
STYLE="$HOME/.config/rofi/clipboard/clipboard.rasi"

#  INFO: Keybinds ---
DELETE_SELECTED_KEY=Ctrl+Delete
CLEAR_ALL_KEY=Ctrl+Shift+Delete

#  INFO: Rofi menu ---
selection=$(cliphist list |
    rofi -dmenu \
        -p "📋" \
        -kb-custom-1 "${DELETE_SELECTED_KEY}" \
        -kb-custom-2 "${CLEAR_ALL_KEY}" \
        -theme "${STYLE}" \
        -format 's')

exit_code=$?

#  INFO: Handle Actions ---
if [ -n "$selection" ]; then
    case $exit_code in
    0)
        echo "$selection" | cliphist decode | wl-copy
        sleep 0.1
        wtype -M ctrl -k v -m ctrl
        ;;
    10)
        echo "$selection" | cliphist delete
        $0
        ;;
    11)
        # Confirmation prompt
        confirm=$(echo -e "No\nYes" | rofi -dmenu -theme "${STYLE}" -p "Clear all history?")
        if [ "$confirm" == "Yes" ]; then
            cliphist wipe
        else
            $0
        fi
        ;;
    esac
fi
