-----------------------------------------------------------
--  HACK: Main keybinds
-----------------------------------------------------------

local defaults = require("modules.defaults")
local home = os.getenv("HOME")

require("modules.keybinds.submaps")

--  INFO: Essential ---
hl.bind(defaults.mainMod .. " + t", hl.dsp.exec_cmd(defaults.terminal)) -- Launch terminal
hl.bind(defaults.mainMod .. " + e", hl.dsp.exec_cmd(defaults.filemanager)) -- Launch file manager
hl.bind(defaults.mainMod .. " + space", hl.dsp.exec_cmd(defaults.launcher)) -- App launcher
hl.bind(defaults.mainMod .. " + b", hl.dsp.exec_cmd(defaults.browser)) -- Launch browser
hl.bind(defaults.mainMod .. " + n", hl.dsp.exec_cmd(defaults.notificationCenter)) -- Launch notification center
hl.bind(defaults.mainMod .. " + Backspace", hl.dsp.window.close()) -- Close active window
hl.bind(defaults.mainMod .. " + I", hl.dsp.exec_cmd(defaults.bar)) -- Launch terminal
------------------------------------------------------

--  INFO: Window management ---
require("modules.keybinds.windows.general") -- Load keybinds for specific layouts
------------------------------------------------------

--  INFO: SYSTEM CONTROLS ---
hl.bind(defaults.mainModShift .. " + Backspace", hl.dsp.exec_cmd(defaults.lockScreen)) -- Lock screen
hl.bind(
	defaults.mainModShift .. " + delete",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'") -- Logout
)
hl.bind(defaults.mainMod .. " + P", hl.dsp.exec_raw(defaults.colorPicker)) -- Color picker
hl.bind(defaults.mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- Drag window with mouse
hl.bind(defaults.mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- Resize window with mouse
------------------------------------------------------

--  INFO: Workspaces ---
for i = 1, 10 do
	local key = i % 10
	hl.bind(defaults.mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(defaults.mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll wheel
hl.bind(defaults.mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(defaults.mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Cycle through workspaces with mainMod + Tab
hl.bind(defaults.mainMod .. " + Tab", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(defaults.mainModShift .. " + Tab", hl.dsp.focus({ workspace = "e-1" }))
------------------------------------------------------

--  INFO: Laptop multimedia keys ---
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/swayosd.sh --display-inc"), -- Increase display brightness
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/swayosd.sh --display-dec"), -- Decrease display brightness
	{ locked = true, repeating = true }
)

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/swayosd.sh --audio-inc"), -- Increase audio volume
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/swayosd.sh --audio-dec"), -- Decrease audio volume
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/swayosd.sh --mute"), -- Mute audio
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/swayosd.sh --mute-mic"), -- Mute microphone
	{ locked = true, repeating = true }
)
------------------------------------------------------

hl.bind("ALT + Space", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/kb_switch.sh")) -- Keybaord layout switcher
hl.bind(defaults.mainMod .. " + C", hl.dsp.exec_cmd(defaults.clipboard))
hl.bind(defaults.mainModShift .. " + C", hl.dsp.exec_cmd(defaults.calculator))
hl.bind(defaults.mainModShift .. " + W", hl.dsp.exec_cmd(defaults.walli))
hl.bind(defaults.mainModShift .. " + P", hl.dsp.exec_cmd(defaults.powermenu))

--  INFO: Lid Switch ---
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("loginctl lock-session"), { locked = true })
hl.bind("switch:on:Lid Switch", hl.dsp.dpms({ action = "disable" }), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.dpms({ action = "enable" }), { locked = true })

--  INFO: Caffeine (toggle hypridle) ---
hl.bind(
	defaults.mainModShift .. " + I",
	hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/caffeine.sh"),
	{ locked = true }
)

hl.bind(defaults.mainModShift .. " + E", hl.dsp.exec_cmd(defaults.emojiPicker)) -- Emoji picker
hl.bind(defaults.mainMod .. " + Return", hl.dsp.exec_cmd(defaults.pacseek)) -- Pacseek

--  INFO: Touchpad ---
local touchpadEnabled = true

local function toggle_touchpad()
	touchpadEnabled = not touchpadEnabled

	hl.device({
		name = "dell08b8:00-0488:121f-touchpad",
		enabled = touchpadEnabled,
	})

	if touchpadEnabled then
		hl.exec_cmd("notify-send -u low -i input-touchpad-on 'Touchpad' 'Enabled' -a 'Hyprland'")
	else
		hl.exec_cmd("notify-send -u low -i input-touchpad-off 'Touchpad' 'Disabled' -a 'Hyprland'")
	end
end

hl.bind("F9", function()
	toggle_touchpad()
end)
