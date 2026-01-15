# SDDM theme

A clean sddm theme to match the theme of hyprland with dynamic wallpaper

## Installation

Clone main repo

```bash
git clone https://github.com/Malick-Tammal/hypr-dotfiles.git
```

Copy sddm folder content to sddm themes folder

```bash
sudo mkdir -p /usr/share/sddm/themes/sddm-modern && sudo cp -r sddm/* /usr/share/sddm/themes/sddm-modern
```

Add this to sddm config file

```toml
[Theme]
Current=sddm-modern
```

If you want to add dynamic wallpaper (make sddm use the same wallpaper as your desktop) remove sudo permession from sddm wallpaper so you can update it "walli wallpaper switcher"

```bash
sudo chown user:group /usr/share/sddm/themes/sddm-modern/wallpaper.png
```

### And you have it
