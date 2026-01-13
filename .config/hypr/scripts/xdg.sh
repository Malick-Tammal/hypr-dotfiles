#!/bin/bash

sleep 1

#  INFO: Stop current services (Clean slate) ---
systemctl --user stop xdg-desktop-portal-hyprland
systemctl --user stop xdg-desktop-portal-gnome
systemctl --user stop xdg-desktop-portal-gtk
systemctl --user stop xdg-desktop-portal

#  INFO: Kill any stubborn processes ---
killall -e xdg-desktop-portal-hyprland
killall -e xdg-desktop-portal-gnome
killall -e xdg-desktop-portal-gtk
killall -e xdg-desktop-portal

sleep 1

#  INFO: Update environment ---
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

#  INFO: Start the Hyprland portal ---
systemctl --user start xdg-desktop-portal-hyprland

sleep 2

#  INFO: Start the main portal ---
systemctl --user start xdg-desktop-portal

#  INFO: Start the gtk portal ---
systemctl --user start xdg-desktop-portal-gtk

sleep 1
notify-send "System" "XDG Portals Reloaded"
