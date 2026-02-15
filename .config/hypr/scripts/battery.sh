#----------------------------------------------------------
#--  HACK: Battery monitor
#----------------------------------------------------------

#  INFO: CONFIGURATION ---
# Battery monitor
LOW_LEVEL=20
CRITICAL_LEVEL=10
ICON_LOW="/usr/share/icons/Colloid-Yellow-Dark/status/symbolic/battery-level-20-symbolic.svg"
ICON_CRITICAL="/usr/share/icons/Colloid-Yellow-Dark/status/symbolic/battery-level-10-symbolic.svg"

# Charger monitor
SOUND=true
SOUND_PLUG="/usr/share/sounds/freedesktop/stereo/window-question.oga"
SOUND_UNPLUG="/usr/share/sounds/freedesktop/stereo/window-attention.oga"
# ------------------------

#  INFO: Prevent spamming
notified_low=false
notified_critical=false

while true; do
    status=$(cat /sys/class/power_supply/BAT0/status)
    capacity=$(cat /sys/class/power_supply/BAT0/capacity)

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

    sleep 60
done
