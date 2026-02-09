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

#----------------------------------------------------------
#--  HACK: Charger monitor
#----------------------------------------------------------

#  INFO: Find the AC Adapter ---
AC_FILE=""
for supply in /sys/class/power_supply/*; do
    if [ -f "$supply/type" ] && grep -q "Mains" "$supply/type"; then
        AC_FILE="$supply/online"
        break
    fi
done

#  INFO: Error handler ---
if [ -z "$AC_FILE" ]; then
    notify-send "Error" "Could not find AC Adapter."
    exit 1
fi

last_state=$(cat "$AC_FILE")

#  INFO: Main logic
while true; do
    current_state=$(cat "$AC_FILE")

    if [ "$current_state" != "$last_state" ]; then
        if "$SOUND"; then

            touch /tmp/silence_notification_sound

            if [ "$current_state" == "1" ]; then
                paplay "$SOUND_PLUG"
                notify-send -a "Power" "Power" "Charger Connected" -a "Hyprland"
            else
                paplay "$SOUND_UNPLUG"
                notify-send -a "Power" "Power" "Charger Disconnected" -a "Hyprland"
            fi

            sleep 0.5
            rm /tmp/silence_notification_sound
        else
            if [ "$current_state" == "1" ]; then
                notify-send -a "Power" "Power" "Charger Connected" -a "Hyprland"
            else
                notify-send -a "Power" "Power" "Charger Disconnected" -a "Hyprland"
            fi
        fi

        last_state=$current_state
    fi
done
