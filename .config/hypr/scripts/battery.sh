#!/bin/bash

#----------------------------------------------------------
#--  HACK: Battery monitor (Udev Event Driven)
#----------------------------------------------------------

#  INFO: CONFIGURATION ---
LOW_LEVEL=20
CRITICAL_LEVEL=10
ICON_LOW="/usr/share/icons/Colloid-Yellow-Dark/status/symbolic/battery-level-20-symbolic.svg"
ICON_CRITICAL="/usr/share/icons/Colloid-Yellow-Dark/status/symbolic/battery-level-10-symbolic.svg"
# ------------------------

#  INFO: Prevent spamming
notified_low=false
notified_critical=false

check_battery() {
    local status=$(cat /sys/class/power_supply/BAT0/status)
    local capacity=$(cat /sys/class/power_supply/BAT0/capacity)

    if [ "$status" = "Discharging" ]; then

        if [ "$capacity" -le $CRITICAL_LEVEL ] && [ "$notified_critical" = false ]; then
            notify-send -u critical -i "$ICON_CRITICAL" "Battery Critical" "Level is at ${capacity}%. Plug in now!" -a "Hyprland"
            notified_critical=true
            notified_low=true

        elif [ "$capacity" -le $LOW_LEVEL ] && [ "$capacity" -gt $CRITICAL_LEVEL ] && [ "$notified_low" = false ]; then
            notify-send -u normal -i "$ICON_LOW" "Battery Low" "Level is at ${capacity}%." -a "Hyprland"
            notified_low=true
        fi

    else
        notified_low=false
        notified_critical=false
    fi
}

#  INFO: Run an initial check on startup
check_battery

#  INFO: Event Listener
udevadm monitor --subsystem-match=power_supply | grep --line-buffered "change" | while read -r; do
    check_battery
done
