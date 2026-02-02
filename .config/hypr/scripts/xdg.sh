#!/bin/bash

#----------------------------------------------------------
#--  HACK: XDG Portals
#----------------------------------------------------------

#  INFO: Stop current services (Clean slate) ---
systemctl --user stop xdg-desktop-portal-hyprland
systemctl --user stop xdg-desktop-portal-gnome
systemctl --user stop xdg-desktop-portal-gtk
systemctl --user stop xdg-desktop-portal

#  INFO: Kill any stubborn processes ---
killall -q xdg-desktop-portal-hyprland
killall -q xdg-desktop-portal-gnome
killall -q xdg-desktop-portal-gtk
killall -q xdg-desktop-portal

sleep 1

#  INFO: Start Gnome Keyring Daemon ---
/usr/bin/gnome-keyring-daemon --start --components=secrets,ssh,pkcs11 &
export SSH_AUTH_SOCK="/run/user/$(id -u)/keyring/ssh"
export GNOME_KEYRING_CONTROL="/run/user/$(id -u)/keyring"

#  INFO: Update environment ---
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP SSH_AUTH_SOCK GNOME_KEYRING_CONTROL
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP SSH_AUTH_SOCK GNOME_KEYRING_CONTROL

sleep 1

#  INFO: Start the Hyprland portal ---
systemctl --user start xdg-desktop-portal-hyprland

#  INFO: Start the main portal ---
systemctl --user start xdg-desktop-portal

#  INFO: Start the gtk portal ---
systemctl --user start xdg-desktop-portal-gtk

notify-send "System" "XDG Portals Reloaded"
