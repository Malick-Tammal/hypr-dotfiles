#!/bin/bash
#----------------------------------------------------------
#--  HACK: Powermenu
#----------------------------------------------------------

# Style
style="$HOME/.config/rofi/powermenu/powermenu.rasi"

# CMDs
uptime="$(uptime -p | sed -e 's/up //g')"

# Options (Icons)
shutdown='⏻'
reboot=''
lock=''
suspend=''
logout=''
yes=''
no=''

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p "Uptime: $uptime" \
        -mesg "Uptime: $uptime" \
        -theme "${style}"
}

# Confirmation CMD - Fixed the theme variable here
confirm_cmd() {
    rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
        -theme-str 'mainbox {children: [ "message", "listview" ];}' \
        -theme-str 'listview {columns: 2; lines: 1;}' \
        -theme-str 'element-text {horizontal-align: 0.5;}' \
        -theme-str 'textbox {horizontal-align: 0.5;}' \
        -dmenu \
        -p 'Confirmation' \
        -mesg 'Are you Sure?' \
        -theme "${style}"
}

# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$shutdown\n$reboot\n$suspend\n$lock\n$logout" | rofi_cmd
}

# Execute Command
run_cmd() {
    selected="$(echo -e "$yes\n$no" | confirm_cmd)"
    if [[ "$selected" == "$yes" ]]; then
        case $1 in
        --shutdown) systemctl poweroff ;;
        --reboot) systemctl reboot ;;
        --suspend) systemctl suspend ;;
        --logout) hyprctl dispatch exit ;;
        esac
    else
        exit 0
    fi
}

# Main Actions
chosen="$(run_rofi)"

case ${chosen} in
$shutdown)
    run_cmd --shutdown
    ;;
$reboot)
    run_cmd --reboot
    ;;
$lock)
    # Lock doesn't need confirmation usually
    hyprlock
    ;;
$suspend)
    run_cmd --suspend
    ;;
$logout)
    run_cmd --logout
    ;;
esac
