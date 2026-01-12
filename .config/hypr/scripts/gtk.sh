#!/bin/bash
# ~/.config/hypr/scripts/gtk.sh

# --- CONFIGURATION ---
THEME="Colloid-Yellow-Dark-Gruvbox" # Set your GTK theme here (e.g., Tokyonight-Dark)
ICONS="Papirus-Dark"                # Set your Icon theme here
FONT="SF Pro Regular 11"            # Set your Font
CURSOR="Moga-Cursor"                # Set your Cursor theme
CURSOR_SIZE=24

# --- APPLY SETTINGS ---
# Apply to GNOME/GTK settings
gsettings set org.gnome.desktop.interface gtk-theme "$THEME"
gsettings set org.gnome.desktop.interface icon-theme "$ICONS"
gsettings set org.gnome.desktop.interface font-name "$FONT"
gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR"
gsettings set org.gnome.desktop.interface cursor-size $CURSOR_SIZE
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

# Cleanup legacy config to ensure no conflicts
rm -f "$HOME/.config/gtk-3.0/settings.ini"
rm -f "$HOME/.config/gtk-4.0/settings.ini"

# Force settings into config files for apps that don't read gsettings
mkdir -p "$HOME/.config/gtk-3.0"
mkdir -p "$HOME/.config/gtk-4.0"

cat >"$HOME/.config/gtk-3.0/settings.ini" <<EOF
[Settings]
gtk-theme-name=$THEME
gtk-icon-theme-name=$ICONS
gtk-font-name=$FONT
gtk-cursor-theme-name=$CURSOR
gtk-cursor-theme-size=$CURSOR_SIZE
gtk-application-prefer-dark-theme=1
EOF

# Copy same settings to GTK 4
cp "$HOME/.config/gtk-3.0/settings.ini" "$HOME/.config/gtk-4.0/settings.ini"

notify-send "Theme" "GTK Styles Applied"
