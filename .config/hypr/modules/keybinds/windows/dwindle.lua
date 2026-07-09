--------------------------------------------------------
--  HACK: Dwindle
--------------------------------------------------------

local key = require("utils.keys")

hl.define_submap("dwindle_layout", function()
	hl.bind(key.F, hl.dsp.window.fullscreen())

	hl.bind(key.L, hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
	hl.bind(key.H, hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
	hl.bind(key.K, hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
	hl.bind(key.J, hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

	hl.bind(key.V, hl.dsp.window.float())
	hl.bind(key.S, hl.dsp.layout("togglesplit"))

	--  TIP: Exit submap
	hl.bind(key.ESCAPE, hl.dsp.submap("reset"))
	hl.bind(key.BACKSPACE, hl.dsp.submap("reset"))
	hl.bind("CTRL + " .. key.C, hl.dsp.submap("reset"))
end)
