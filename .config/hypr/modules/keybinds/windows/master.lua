-----------------------------------------------------------
--  HACK: Master
-----------------------------------------------------------
local key = require("utils.keys")

hl.define_submap("master_layout", function()
	hl.bind(key.L, hl.dsp.layout("mfact +0.02"), { repeating = true })
	hl.bind(key.H, hl.dsp.layout("mfact -0.02"), { repeating = true })
	hl.bind(key.S, hl.dsp.layout("swapwithmaster"))

	hl.bind(key.V, hl.dsp.window.float())
	hl.bind("SHIFT + " .. key.F, hl.dsp.window.fullscreen())

	--  TIP: Exit submap
	hl.bind(key.ESCAPE, hl.dsp.submap("reset"))
	hl.bind(key.BACKSPACE, hl.dsp.submap("reset"))
	hl.bind("CTRL + " .. key.C, hl.dsp.submap("reset"))
end)
