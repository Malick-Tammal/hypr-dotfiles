-----------------------------------------------------------
--  HACK: Autostart
-----------------------------------------------------------

local defaults = require("modules.defaults")

hl.on("hyprland.start", function()
	local home = os.getenv("HOME")

	hl.exec_cmd(home .. "/.config/hypr/scripts/xdg.sh")
	hl.exec_cmd(home .. "/.config/hypr/scripts/gtk.sh")

	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

	hl.exec_cmd("awww-daemon")

	hl.exec_cmd("swaync")
	hl.exec_cmd("swayosd-server")

	hl.exec_cmd("quickshell")

	hl.exec_cmd("hypridle")

	hl.exec_cmd("udiskie")

	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("cliphist wipe")

	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic " .. defaults.cursorSize)

	hl.exec_cmd("hyprpm reload")
	hl.exec_cmd("hyprctl reload")

	hl.exec_cmd(home .. "/.config/hypr/scripts/notification_sound.sh")

	hl.exec_cmd(home .. "/.config/hypr/scripts/battery.sh")
	hl.exec_cmd(home .. "/.config/hypr/scripts/charger.sh")

	hl.exec_cmd("[workspace special:hidden silent] nautilus")

	hl.exec_cmd("xhost +si:localuser:root")

	-- hl.exec_cmd("kdeconnect-indicator")
end)
