#!/bin/bash
#----------------------------------------------------------
#--  HACK: Powermenu
#----------------------------------------------------------

#  INFO: Styling ---
style="$HOME/.config/rofi/powermenu/powermenu.rasi"

#  INFO: Uptime --- uptime="$(uptime -p | sed -e 's/up //g')"
#  INFO: Icons ---
shutdown='⏻'
reboot=''
lock=''
suspend=''
logout=''
yes=''
no=''

#  INFO: Rofi menu ---
rofi_cmd() {
    rofi -dmenu \
        -p "Uptime: $uptime" \
        -mesg "Uptime: $uptime" \
        -theme "${style}"
}

#  INFO: Confirmation popup ---
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

#  INFO: Pass variables to rofi ---
run_rofi() {
    echo -e "$shutdown\n$reboot\n$suspend\n$lock\n$logout" | rofi_cmd
}

#  INFO: Exec cmds ---
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

#  INFO: Main actions ---
chosen="$(run_rofi)"

case ${chosen} in
$shutdown)
    run_cmd --shutdown
    ;;
$reboot)
    run_cmd --reboot
    ;;
$lock)
    hyprlock
    ;;
$suspend)
    run_cmd --suspend
    ;;
$logout)
    run_cmd --logout
    ;;
esac
