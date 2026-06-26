-----------------------------------------------------------
--  HACK: Environment variables
-----------------------------------------------------------

--  INFO: XDG Desktop Portal
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_MENU_PREFIX", "arch-")

--  INFO: GDK
hl.env("GDK_SCALE", "1")
hl.env("GDK_DPI_SCALE", "1.1")
hl.env("GSK_RENDERER", "gl")
hl.env("GDK_BACKEND", "wayland,x11,*")

--  INFO: Firefox & Electron
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("OZONE_PLATFORM", "wayland")

--  INFO: QT
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_ENABLE_HIGHDPI_SCALING", "1")

-- INFO: Toolkit Backends
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

-- INFO: Hardware Acceleration / Graphics Drivers
hl.env("LIBVA_DRIVER_NAME", "iHD")
hl.env("MESA_LOADER_DRIVER_NAME", "iris")

--  INFO: Stability Fixes
hl.env("GS_DEBUG", "0")

--  INFO: Cursor
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_CURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")

--  INFO: Default terminal
hl.env("TERMINAL", "kitty")

--  INFO: Default browser
hl.env("BROWSER", "firefox")
