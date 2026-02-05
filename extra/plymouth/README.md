# Plymouth animation

A custom plymouth animation | custom boot animation

## Installation

Clone main repo

```bash
git clone https://github.com/Malick-Tammal/hypr-dotfiles.git
```

Copy plymouth folder content to plymouth themes folder

```bash
sudo mkdir -p /usr/share/plymouth/themes/arch-mac && sudo cp -r extra/plymouth/* /usr/share/plymouth/themes/arch-mac
```

Now apply the theme

```bash
sudo plymouth-set-default-theme -R arch-mac
```

### And you have it
