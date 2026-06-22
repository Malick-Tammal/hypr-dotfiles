#!/bin/bash

#----------------------------------------------------------
#--  HACK: GTK theming
#----------------------------------------------------------

#  INFO: CONFIGURATION ---
THEME="Colloid-Monokai"        # Set GTK theme
FONT="SF Pro Regular 11"       # Set Font
CURSOR="Bibata-Modern-Classic" # Set Cursor theme
CURSOR_SIZE=24                 # Set Cursor size
BUTTON_LAYOUT="appmenu:"       # Set Header bar menu  TIP: Show all of them : "appmenu:minimize,maximize,close"
ICONS="Colloid-Orange-Dark"    # Set icon theme
TERMINAL="kitty"               # Set default terminal
#---------------------------

#  INFO: APPLY GTK SETTINGS ---
gsettings set org.gnome.desktop.interface gtk-theme "$THEME"
gsettings set org.gnome.desktop.interface icon-theme "$ICONS"
gsettings set org.gnome.desktop.interface font-name "$FONT"
gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR"
gsettings set org.gnome.desktop.interface cursor-size $CURSOR_SIZE
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.wm.preferences button-layout "$BUTTON_LAYOUT"
gsettings set org.gnome.desktop.default-applications.terminal exec "$TERMINAL"
gsettings set org.gnome.desktop.default-applications.terminal exec-arg "-e"
gsettings set org.gnome.desktop.interface text-scaling-factor 1

#  INFO: FLATPAK FIXES ---
if command -v flatpak &>/dev/null; then
    flatpak override --user --filesystem="$HOME/.themes"
    flatpak override --user --filesystem="$HOME/.icons"
    flatpak override --user --filesystem="$HOME/.local/share/themes"
    flatpak override --user --filesystem="$HOME/.local/share/icons"
    flatpak override --user --filesystem="$HOME/dotfiles/.themes"
    flatpak override --user --filesystem=xdg-config/gtk-3.0
    flatpak override --user --filesystem=xdg-config/gtk-4.0
    flatpak override --user --env=GTK_THEME="$THEME"
    flatpak override --user --filesystem="$HOME/.local/share/fonts"
    flatpak override --user --filesystem="$HOME/.fonts"
fi

#  INFO: CLEANUP OF GTK CONFIGS ---
rm -f "$HOME/.config/gtk-3.0/settings.ini"
rm -f "$HOME/.config/gtk-4.0/settings.ini"
mkdir -p "$HOME/.config/gtk-3.0"
mkdir -p "$HOME/.config/gtk-4.0"

#  INFO: Gtk 3.0 --
cat >"$HOME/.config/gtk-3.0/settings.ini" <<EOF
[Settings]
gtk-theme-name=$THEME
gtk-font-name=$FONT
gtk-cursor-theme-name=$CURSOR
gtk-cursor-theme-size=$CURSOR_SIZE
gtk-icon-theme-name=$ICONS
gtk-application-prefer-dark-theme=1
gtk-decoration-layout=appmenu:
EOF

#  INFO: Gtk 4.0 --
cat >"$HOME/.config/gtk-4.0/settings.ini" <<EOF
[Settings]
gtk-theme-name=$THEME
gtk-font-name=$FONT
gtk-cursor-theme-name=$CURSOR
gtk-cursor-theme-size=$CURSOR_SIZE
gtk-icon-theme-name=$ICONS
gtk-decoration-layout=appmenu:
gtk-application-prefer-dark-theme=1
EOF

#  INFO: For gtk 4.0 apps --
THEME_DIR=""
if [ -d "$HOME/.themes/$THEME" ]; then
    THEME_DIR="$HOME/.themes/$THEME"
elif [ -d "$HOME/.local/share/themes/$THEME" ]; then
    THEME_DIR="$HOME/.local/share/themes/$THEME"
elif [ -d "/usr/share/themes/$THEME" ]; then
    THEME_DIR="/usr/share/themes/$THEME"
fi

if [ -n "$THEME_DIR" ] && [ -d "$THEME_DIR/gtk-4.0" ]; then
    echo "Linking GTK4 CSS from $THEME_DIR..."
    ln -sf "$THEME_DIR/gtk-4.0/gtk.css" "$HOME/.config/gtk-4.0/gtk.css"
    ln -sf "$THEME_DIR/gtk-4.0/gtk-dark.css" "$HOME/.config/gtk-4.0/gtk-dark.css"
    ln -sf "$THEME_DIR/gtk-4.0/assets" "$HOME/.config/gtk-4.0/assets"
else
    echo "Warning: GTK4 theme assets not found for $THEME"
fi

notify-send "Theme" "GTK Styles Applied" -a "Hyprland"
