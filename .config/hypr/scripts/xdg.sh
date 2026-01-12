#!/bin/bash
# ~/.config/hypr/scripts/xdg.sh

sleep 1

# Kill all possible running instances
killall -e xdg-desktop-portal-hyprland
killall -e xdg-desktop-portal-gnome
killall -e xdg-desktop-portal-lxqt
killall -e xdg-desktop-portal-wlr
killall -e xdg-desktop-portal-gtk
killall -e xdg-desktop-portal-kde
killall xdg-desktop-portal

sleep 1

# 2. Update the environment (Important: wait for it to finish)
# dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
# systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# Start the specific Hyprland implementation first
/usr/lib/xdg-desktop-portal-hyprland &

sleep 2

# Start the generic portal (must run AFTER the specific one)
/usr/lib/xdg-desktop-portal &

# Start xdg-desktop-portal-gtk
if [ -f /usr/lib/xdg-desktop-portal-gtk ]; then
    /usr/lib/xdg-desktop-portal-gtk &
    sleep $_sleep1
fi

sleep 1
notify-send "System" "XDG Portals Reloaded"
