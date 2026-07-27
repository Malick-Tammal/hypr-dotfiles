-----------------------------------------------------------
--  HACK: Main keybinds
-----------------------------------------------------------

local defaults = require("modules.defaults")
local home = os.getenv("HOME")
local toggles = require("utils.toggles")
local key = require("utils.keys")

require("modules.keybinds.submaps")

--  INFO: Essential ---
hl.bind(defaults.mainMod .. " + " .. key.T, hl.dsp.exec_cmd(defaults.terminal)) -- Launch terminal
hl.bind(defaults.mainMod .. " + " .. key.E, hl.dsp.exec_cmd(defaults.filemanager)) -- Launch file manager
hl.bind(defaults.mainMod .. " + " .. key.SPACE, hl.dsp.exec_cmd(defaults.launcher)) -- App launcher
hl.bind(defaults.mainMod .. " + " .. key.B, hl.dsp.exec_cmd(defaults.browser)) -- Launch browser
hl.bind(defaults.mainMod .. " + " .. key.N, hl.dsp.exec_cmd(defaults.notificationCenter)) -- Launch notification center
hl.bind(defaults.mainMod .. " + " .. key.BACKSPACE, hl.dsp.window.close()) -- Close active window
hl.bind(defaults.mainMod .. " + " .. key.I, hl.dsp.exec_cmd(defaults.bar)) -- Launch terminal
------------------------------------------------------

--  INFO: Window management ---
require("modules.keybinds.windows.general") -- Load keybinds for specific layouts
------------------------------------------------------

--  INFO: SYSTEM CONTROLS ---
hl.bind(defaults.mainModShift .. " + " .. key.BACKSPACE, hl.dsp.exec_cmd(defaults.lockScreen)) -- Lock screen
hl.bind(
	defaults.mainModShift .. " + " .. key.DELETE,
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'") -- Logout
)
hl.bind(defaults.mainMod .. " + " .. key.P, hl.dsp.exec_raw(defaults.colorPicker)) -- Color picker
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
hl.bind(defaults.mainMod .. " + " .. key.TAB, hl.dsp.focus({ workspace = "e+1" }))
hl.bind(defaults.mainModShift .. " + " .. key.TAB, hl.dsp.focus({ workspace = "e-1" }))
------------------------------------------------------

--  INFO: Laptop multimedia keys ---
hl.bind(
	key.BRIGHT_UP,
	hl.dsp.exec_cmd("qs ipc call brightness increase"), -- Increase display brightness
	{ locked = true, repeating = true }
)
hl.bind(
	key.BRIGHT_DOWN,
	hl.dsp.exec_cmd("qs ipc call brightness decrease"), -- Decrease display brightness
	{ locked = true, repeating = true }
)

hl.bind(
	key.VOL_UP,
	hl.dsp.exec_cmd("qs ipc call volume increase"), -- Increase audio volume
	{ locked = true, repeating = true }
)
hl.bind(
	key.VOL_DOWN,
	hl.dsp.exec_cmd("qs ipc call volume decrease"), -- Decrease audio volume
	{ locked = true, repeating = true }
)
hl.bind(
	key.MUTE,
	hl.dsp.exec_cmd("qs ipc call volume mute"), -- Mute audio
	{ locked = true, repeating = true }
)
hl.bind(
	key.MIC_MUTE,
	hl.dsp.exec_cmd("qs ipc call mic mute"), -- Mute microphone
	{ locked = true, repeating = true }
)
------------------------------------------------------

hl.bind("ALT + Space", hl.dsp.exec_cmd("hyprctl switchxkblayout all next")) -- Keybaord layout switcher
hl.bind(defaults.mainMod .. " + " .. key.C, hl.dsp.exec_cmd(defaults.clipboard))
hl.bind(defaults.mainModShift .. " + " .. key.C, hl.dsp.exec_cmd(defaults.calculator))
hl.bind(defaults.mainModShift .. " + " .. key.W, hl.dsp.exec_cmd(defaults.wallpaperManager))
hl.bind(defaults.mainModShift .. " + " .. key.P, hl.dsp.exec_cmd(defaults.powermenu))

--  INFO: Lid Switch ---
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("loginctl lock-session"), { locked = true })
hl.bind("switch:on:Lid Switch", hl.dsp.dpms({ action = "disable" }), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("brightnessctl -r"), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.dpms({ action = "enable" }), { locked = true })

hl.bind(defaults.mainModShift .. " + " .. key.I, toggles.toggle_caffeine, { locked = true }) -- Caffeine (toggle hypridle)

hl.bind(defaults.mainModShift .. " + " .. key.E, hl.dsp.exec_cmd(defaults.emojiPicker)) -- Emoji picker
hl.bind(defaults.mainMod .. " + " .. key.RETURN, hl.dsp.exec_cmd(defaults.pacseek)) -- Pacseek

-- Toggle touchapd
hl.bind(key.F9, function()
	toggles.toggle_touchpad()
end)

-- Toggle gamemode
hl.bind(defaults.mainModShift .. " + " .. key.G, function()
	toggles.toggle_game_mode()
end)
