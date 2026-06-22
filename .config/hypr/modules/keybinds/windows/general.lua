--------------------------------------------------------
--  HACK: General
--------------------------------------------------------

local defaults = require("modules.defaults")

--  INFO: Custom keybinds for specific layouts
require("modules.keybinds.windows.dwindle")
require("modules.keybinds.windows.scrolling")
require("modules.keybinds.windows.master")

hl.bind(defaults.mainMod .. " + W", function()
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
hl.bind(defaults.mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(defaults.mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(defaults.mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(defaults.mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind("ALT + Tab", hl.dsp.window.cycle_next())
hl.bind("ALT + Tab", hl.dsp.window.bring_to_top())

--  INFO: Window movement
hl.bind(defaults.mainModShift .. " + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(defaults.mainModShift .. " + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(defaults.mainModShift .. " + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(defaults.mainModShift .. " + J", hl.dsp.window.move({ direction = "down" }))
