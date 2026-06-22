-----------------------------------------------------------
--  HACK: Defaults
-----------------------------------------------------------

local home = os.getenv("HOME")

local M = {}

M.gapsIn = 5
M.gapsOut = 10
M.isBlur = false
M.cursorSize = 24

M.mainMod = "SUPER"
M.mainModShift = "SUPER + SHIFT"

M.terminal = "kitty"
M.filemanager = "nautilus --new-window"
M.browser = "firefox"
M.notificationCenter = "swaync-client -t -sw"
M.lockScreen = "hyprlock"
M.powermenu = "qs ipc call powermenu toggle"
M.walli = "qs ipc call walli toggle"
M.btManager = "blueman-manager"
M.wifiManager = "nmgui"
M.audioManager = "pavucontrol"
M.pacseek = "kitty --class appgrid-pacseek --title 'Package installer' -e pacseek"

M.launcher = home .. "/.config/rofi/launcher/script.sh"
M.clipboard = home .. "/.config/rofi/clipboard/script.sh"
M.calculator = home .. "/.config/rofi/calc/script.sh"
M.emojiPicker = home .. "/.config/rofi/emoji/script.sh"
M.colorPicker = home .. "/.config/hypr/scripts/color_picker.sh"

return M
