-----------------------------------------------------------
--  HACK: Windows
-----------------------------------------------------------

local defaults = require("modules.defaults")

hl.window_rule({
	name = "network-manager",
	match = { class = "nm-connection-editor" },
	float = true,
})

hl.window_rule({
	name = "wifi-manager",
	match = { class = "org.twosheds.iwgtk" },
	float = true,
	center = true,
	size = { 600, 600 },
})

hl.window_rule({
	name = "wifi-manager2",
	match = { class = "iwgtk" },
	float = true,
	center = true,
	size = { 300, 100 },
})

hl.window_rule({
	name = "wifi-manager3",
	match = { class = "com.network.manager" },
	float = true,
	center = true,
})

hl.window_rule({
	name = "firefox-popups",
	match = { class = "firefox", title = [[Save As|Opening|Library|Extension:.*|Save Image.*|File Upload.*]] },
	float = true,
	center = true,
})

hl.window_rule({
	name = "pavucontrol",
	match = { class = "org.pulseaudio.pavucontrol" },
	float = true,
	center = true,
})

hl.window_rule({
	name = "pacseek",
	match = { class = "appgrid-pacseek" },
	float = true,
	center = true,
	size = { 1000, 600 },
})

hl.window_rule({
	name = "nautilus",
	match = { class = "org.gnome.Nautilus" },
	float = true,
	center = true,
	size = { 1300, 800 },
	opacity = defaults.isBlur and "0.9" or "1",
})

hl.window_rule({
	name = "sushi",
	match = { class = "org.gnome.NautilusPreviewer" },
	float = true,
	center = true,
	size = { 1000, 700 },
})

hl.window_rule({
	name = "nemo",
	match = { class = "nemo" },
	float = true,
	center = true,
	size = { 1300, 800 },
	opacity = defaults.isBlur and "0.9" or "1",
})

hl.window_rule({
	name = "gnome-calculator",
	match = { class = "org.gnome.Calculator" },
	float = true,
	center = true,
	size = { 383, 616 },
	opacity = defaults.isBlur and "0.9" or "1",
})

hl.window_rule({
	name = "mission-center",
	match = { class = "io.missioncenter.MissionCenter" },
	float = true,
	center = true,
	opacity = defaults.isBlur and "0.9" or "1",
})

hl.window_rule({
	name = "gedit",
	match = { class = "gedit" },
	float = true,
	center = true,
	opacity = defaults.isBlur and "0.9" or "1",
})

hl.window_rule({
	name = "overskride",
	match = { class = "io.github.kaii_lb.Overskride" },
	float = true,
	center = true,
	opacity = defaults.isBlur and "0.9" or "1",
})

hl.window_rule({
	name = "blueman",
	match = { class = "blueman-manager" },
	float = true,
	center = true,
	opacity = defaults.isBlur and "0.9" or "1",
})

hl.window_rule({
	name = "dev-auto-float",
	match = { title = ".*Float.*" },
	float = true,
	center = true,
})

hl.window_rule({
	name = "dev-tools",
	match = { title = "Devtools" },
	float = true,
	center = true,
})

hl.window_rule({
	name = "electron-dev",
	match = { title = ".*Console.*" },
	float = true,
	center = true,
})

hl.window_rule({
	name = "mpv",
	match = { class = "mpv" },
	float = true,
	center = true,
})

hl.window_rule({
	name = "gnome-eye",
	match = { class = "org.gnome.eog" },
	float = true,
	center = true,
})

hl.window_rule({
	name = "gnome-videos",
	match = { class = "org.gnome.Totem" },
	float = true,
	center = true,
})

hl.window_rule({
	name = "screen-share",
	match = { class = "hyprland-share-picker" },
	float = true,
	center = true,
})

hl.window_rule({
	name = "waydroid",
	match = { class = "Waydroid" },
	float = true,
	center = true,
	size = { 600, 950 },
})

hl.window_rule({
	name = "waydroid",
	match = { class = "Waydroid" },
	workspace = "name:special:Android",
	fullscreen = true,
})

hl.window_rule({
	name = "jetbrains-fix",
	match = {
		class = "jetbrains-.*",
		title = [[^$|^\s$|^win\d+$]],
		float = true,
	},
	no_initial_focus = true,
})

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "xwayland-context-menu",
	match = {
		class = ".*",
		title = ".*",
	},
	no_blur = true,
})

hl.window_rule({
	name = "disable-blur",
	match = { class = ".*" },
	no_blur = not defaults.isBlur,
})

hl.window_rule({
	name = "file-dialogs",
	match = {
		title = [[^(Open File|Select a File|Open Folder|Save As|Library|File Upload)(.*)$|^(.*)(wants to save|wants to open)$]],
	},
	center = true,
	float = true,
})

hl.window_rule({
	name = "file-picker-popup",
	match = { class = "xdg-desktop-portal-gtk" },
	float = true,
	size = "800 600",
})

hl.window_rule({
	name = "nautilus-popups",
	match = {
		class = "org.gnome.Nautilus",
		title = ".*Confirm|Copying|Moving|Deleting|Extracting|Compressing|Properties|completed.*",
	},
	float = true,
	center = true,
})

hl.window_rule({
	name = "nautilus-popup2",
	match = { class = "org.gnome.Nautilus", title = ".*" },
	float = true,
	center = true,
})

hl.window_rule({
	name = "nautilus-xdg",
	match = { class = "xdg-desktop-portal-gnome" },
	float = true,
})

hl.window_rule({
	name = "nautilus-progress",
	match = { title = "File Operation Progress" },
	float = true,
})

hl.window_rule({
	name = "nemo-popups",
	match = {
		class = "nemo",
		title = ".*(Confirm|Copying|Moving|Deleting|Extracting|Compressing|Properties|completed).*",
	},
	float = true,
	center = true,
})

hl.window_rule({
	name = "nemo-popup2",
	match = { class = "nemo", title = ".*" },
	float = true,
	center = true,
})

hl.window_rule({
	name = "Dolphin copy",
	match = { title = "Copying.*Dolphin" },
	move = "40 80",
})

hl.window_rule({
	name = "picture-in-picture",
	match = { title = [[^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$]] },
	float = true,
	pin = true,
	keep_aspect_ratio = true,
	move = "(monitor_w*.73) (monitor_h*.72)",
	size = "(monitor_w*.25) (monitor_h.25)",
})

hl.window_rule({
	name = "firefox-pip",
	match = { class = "firefox", title = "Picture-in-Picture" },
	float = true,
	pin = true,
})

hl.window_rule({
	name = "firefox-about",
	match = { class = "firefox", title = "About Mozilla Firefox" },
	float = true,
})

hl.window_rule({
	name = "zen-pip",
	match = { class = "zen.", title = "Picture-in-Picture" },
	float = true,
	pin = true,
})

hl.window_rule({
	name = "zen-about",
	match = { class = "zen.*", title = "About Zen Browser|Zen Browser.*Sharing Indicator" },
	float = true,
	center = true,
})

hl.window_rule({
	name = "zen-popups",
	match = {
		class = "zen.*",
		title = "Open File|Select a File|Choose wallpaper|Open Folder|Save As|Library|File Upload",
	},
	float = true,
	center = true,
})

hl.window_rule({
	name = "vlc",
	match = { class = "vlc" },
	float = true,
	center = true,
	size = "1263 779",
})

hl.window_rule({
	name = "vlc-picker",
	match = { class = "vlc", title = "Open Directory" },
	float = true,
	size = "800 500",
})

hl.window_rule({
	name = "vlc-menus",
	match = { class = "vlc", title = "negative:.+" },
	float = true,
})

hl.window_rule({
	name = "vlc-other",
	match = { class = "vlc", title = "vlc" },
	size = "",
})

hl.window_rule({
	name = "windscribe",
	match = { class = "Windscribe" },
	float = true,
	border_size = 0,
})

hl.window_rule({
	name = "kdenlive",
	match = { class = "org.kde.kdenlive", title = "Kdenlive" },
	float = true,
	border_size = 0,
	rounding = 0,
	rounding_power = 1,
})
