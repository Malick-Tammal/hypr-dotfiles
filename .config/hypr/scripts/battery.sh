#!/bin/bash

#----------------------------------------------------------
#--  HACK: Battery monitor with Auto-Suspend
#----------------------------------------------------------

sleep 5

#  INFO: CONFIGURATION ---
LOW_LEVEL=20
CRITICAL_LEVEL=10
EMERGENCY_LEVEL=5
ICON_LOW="/usr/share/icons/Colloid-Yellow-Dark/status/symbolic/battery-level-20-symbolic.svg"
ICON_CRITICAL="/usr/share/icons/Colloid-Yellow-Dark/status/symbolic/battery-level-10-symbolic.svg"
# ------------------------

notified_low=false
notified_critical=false

check_battery() {
    local status=$(cat /sys/class/power_supply/BAT0/status)
    local capacity=$(cat /sys/class/power_supply/BAT0/capacity)

    if [ "$status" = "Discharging" ]; then

        #  TIP: Emergency Suspend
        if [ "$capacity" -le $EMERGENCY_LEVEL ]; then
            notify-send -u critical -i "$ICON_CRITICAL" "Battery Empty" "Suspending system to prevent data loss..." -a "Hyprland"
            sleep 2
            systemctl suspend

        #  TIP: Critical
        elif [ "$capacity" -le $CRITICAL_LEVEL ] && [ "$notified_critical" = false ]; then
            if notify-send -u critical -i "$ICON_CRITICAL" "Battery Critical" "Level is at ${capacity}%. Plug in now!" -a "Hyprland"; then
                notified_critical=true
                notified_low=true
            fi

        #  TIP: Low
        elif [ "$capacity" -le $LOW_LEVEL ] && [ "$capacity" -gt $CRITICAL_LEVEL ] && [ "$notified_low" = false ]; then
            if notify-send -u normal -i "$ICON_LOW" "Battery Low" "Level is at ${capacity}%." -a "Hyprland"; then
                notified_low=true
            fi
        fi

    else
        notified_low=false
        notified_critical=false
    fi
}

while true; do
    check_battery
    sleep 60
done
