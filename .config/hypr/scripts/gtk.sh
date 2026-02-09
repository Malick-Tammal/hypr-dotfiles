#!/bin/bash

#----------------------------------------------------------
#--  HACK: GTK theming
#----------------------------------------------------------

#  INFO: CONFIGURATION ---
THEME="Colloid-Monokai"     # Set GTK theme
FONT="SF Pro Regular 11"    # Set Font
CURSOR="Moga-Cursor"        # Set Cursor theme
CURSOR_SIZE=24              # Set Cursor size
BUTTON_LAYOUT="appmenu:"    # Set Header bar menu  TIP: Show all of them : "appmenu:minimize,maximize,close"
ICONS="Colloid-Orange-Dark" # Set icon theme
TERMINAL="kitty"            # Set default terminal
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
fi

#  INFO: CLEANUP OF GTK CONFIGS ---
rm -f "$HOME/.config/gtk-3.0/settings.ini"
rm -f "$HOME/.config/gtk-4.0/settings.ini"
mkdir -p "$HOME/.config/gtk-3.0"
mkdir -p "$HOME/.config/gtk-4.0"

#  INFO: Gtk 3.0
cat >"$HOME/.config/gtk-3.0/settings.ini" <<EOF
[Settings]
gtk-theme-name=$THEME
gtk-font-name=$FONT
gtk-cursor-theme-name=$CURSOR
gtk-cursor-theme-size=$CURSOR_SIZE
gtk-icon-theme-name=$ICONS
gtk-application-prefer-dark-theme=1
EOF

#  INFO: Gtk 4.0
cat >"$HOME/.config/gtk-4.0/settings.ini" <<EOF
[Settings]
gtk-theme-name=$THEME
gtk-font-name=$FONT
gtk-cursor-theme-name=$CURSOR
gtk-cursor-theme-size=$CURSOR_SIZE
gtk-icon-theme-name=$ICONS
EOF

#  INFO: For gtk 4.0 apps
ln -sf ~/.themes/"$THEME"/gtk-4.0/gtk.css ~/.config/gtk-4.0/gtk.css
ln -sf ~/.themes/"$THEME"/gtk-4.0/gtk-dark.css ~/.config/gtk-4.0/gtk-dark.css
ln -sf ~/.themes/"$THEME"/gtk-4.0/assets ~/.config/gtk-4.0/assets

notify-send "Theme" "GTK Styles Applied" -a "Hyprland"
