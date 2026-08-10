-----------------------------------------------------------
--  HACK: Main keybinds
-----------------------------------------------------------

local configs = require("modules.configs")
local home = os.getenv("HOME")
local toggles = require("utils.toggles")
local key = require("utils.keys")

require("modules.keybinds.submaps")

--  INFO: Essential ---
hl.bind(configs.mainMod .. " + " .. key.T, hl.dsp.exec_cmd(configs.terminal)) -- Launch terminal
hl.bind(configs.mainMod .. " + " .. key.E, hl.dsp.exec_cmd(configs.filemanager)) -- Launch file manager
hl.bind(configs.mainMod .. " + " .. key.SPACE, hl.dsp.exec_cmd(configs.launcher)) -- App launcher
hl.bind(configs.mainMod .. " + " .. key.B, hl.dsp.exec_cmd(configs.browser)) -- Launch browser
hl.bind(configs.mainMod .. " + " .. key.N, hl.dsp.exec_cmd(configs.notificationCenter)) -- Launch notification center
hl.bind(configs.mainMod .. " + " .. key.BACKSPACE, hl.dsp.window.close()) -- Close active window
hl.bind(configs.mainMod .. " + " .. key.I, hl.dsp.exec_cmd(configs.bar)) -- Launch terminal
------------------------------------------------------

--  INFO: Window management ---
require("modules.keybinds.windows.general") -- Load keybinds for specific layouts
------------------------------------------------------

--  INFO: SYSTEM CONTROLS ---
hl.bind(configs.mainModShift .. " + " .. key.BACKSPACE, hl.dsp.exec_cmd(configs.lockScreen)) -- Lock screen
hl.bind(
	configs.mainModShift .. " + " .. key.DELETE,
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'") -- Logout
)
hl.bind(configs.mainMod .. " + " .. key.P, hl.dsp.exec_raw(configs.colorPicker)) -- Color picker
hl.bind(configs.mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- Drag window with mouse
hl.bind(configs.mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- Resize window with mouse
------------------------------------------------------

--  INFO: Workspaces ---
for i = 1, 10 do
	local key = i % 10
	hl.bind(configs.mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(configs.mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll wheel
hl.bind(configs.mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(configs.mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Cycle through workspaces with mainMod + Tab
hl.bind(configs.mainMod .. " + " .. key.TAB, hl.dsp.focus({ workspace = "e+1" }))
hl.bind(configs.mainModShift .. " + " .. key.TAB, hl.dsp.focus({ workspace = "e-1" }))
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
hl.bind(configs.mainMod .. " + " .. key.C, hl.dsp.exec_cmd(configs.clipboard))
hl.bind(configs.mainModShift .. " + " .. key.C, hl.dsp.exec_cmd(configs.calculator))
hl.bind(configs.mainModShift .. " + " .. key.W, hl.dsp.exec_cmd(configs.wallpaperManager))
hl.bind(configs.mainModShift .. " + " .. key.P, hl.dsp.exec_cmd(configs.powermenu))

--  INFO: Lid Switch ---
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("loginctl lock-session"), { locked = true })
hl.bind("switch:on:Lid Switch", hl.dsp.dpms({ action = "disable" }), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("brightnessctl -r"), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.dpms({ action = "enable" }), { locked = true })

hl.bind(configs.mainModShift .. " + " .. key.I, toggles.toggle_caffeine, { locked = true }) -- Caffeine (toggle hypridle)

hl.bind(configs.mainModShift .. " + " .. key.E, hl.dsp.exec_cmd(configs.emojiPicker)) -- Emoji picker
hl.bind(configs.mainMod .. " + " .. key.RETURN, hl.dsp.exec_cmd(configs.pacseek)) -- Pacseek

-- Toggle touchapd
hl.bind(key.F9, function()
	toggles.toggle_touchpad()
end)

-- Toggle gamemode
hl.bind(configs.mainModShift .. " + " .. key.G, hl.dsp.exec_cmd("qs ipc call gamemode toggle"))
