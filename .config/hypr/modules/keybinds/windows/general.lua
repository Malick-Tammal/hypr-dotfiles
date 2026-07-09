--------------------------------------------------------
--  HACK: General
--------------------------------------------------------

local defaults = require("modules.defaults")
local key = require("utils.keys")

--  INFO: Custom keybinds for specific layouts
require("modules.keybinds.windows.dwindle")
require("modules.keybinds.windows.scrolling")
require("modules.keybinds.windows.master")

hl.bind(defaults.mainMod .. " + " .. key.W, function()
	local ws = hl.get_active_workspace()

	if not ws then
		return
	end

	if ws.tiled_layout == "dwindle" then
		hl.dispatch(hl.dsp.submap("dwindle_layout"))
	elseif ws.tiled_layout == "scrolling" then
		hl.dispatch(hl.dsp.submap("scrolling_layout"))
	elseif ws.tiled_layout == "master" then
		hl.dispatch(hl.dsp.submap("master_layout"))
	end
end)

--  INFO: Window focus
hl.bind(defaults.mainMod .. " + " .. key.L, hl.dsp.focus({ direction = "right" }))
hl.bind(defaults.mainMod .. " + " .. key.H, hl.dsp.focus({ direction = "left" }))
hl.bind(defaults.mainMod .. " + " .. key.K, hl.dsp.focus({ direction = "up" }))
hl.bind(defaults.mainMod .. " + " .. key.J, hl.dsp.focus({ direction = "down" }))

hl.bind("ALT + " .. key.TAB, hl.dsp.window.cycle_next())
hl.bind("ALT + " .. key.TAB, hl.dsp.window.bring_to_top())

--  INFO: Window movement
hl.bind(defaults.mainModShift .. " + " .. key.L, hl.dsp.window.move({ direction = "right" }))
hl.bind(defaults.mainModShift .. " + " .. key.H, hl.dsp.window.move({ direction = "left" }))
hl.bind(defaults.mainModShift .. " + " .. key.K, hl.dsp.window.move({ direction = "up" }))
hl.bind(defaults.mainModShift .. " + " .. key.J, hl.dsp.window.move({ direction = "down" }))
