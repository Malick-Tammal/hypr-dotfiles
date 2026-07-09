--------------------------------------------------------
--  HACK: Scrolling
--------------------------------------------------------
local key = require("utils.keys")

hl.define_submap("scrolling_layout", function()
	hl.bind(key.L, hl.dsp.layout("colresize +0.02"), { repeating = true })
	hl.bind(key.H, hl.dsp.layout("colresize -0.02"), { repeating = true })

	hl.bind(key.F, hl.dsp.layout("colresize +conf"))

	hl.bind(key.R, hl.dsp.layout("promote"))
	hl.bind(key.C, hl.dsp.layout("fit visible"))

	hl.bind(key.V, hl.dsp.window.float())
	hl.bind("SHIFT + " .. key.F, hl.dsp.window.fullscreen())

	--  TIP: Exit submap
	hl.bind(key.ESCAPE, hl.dsp.submap("reset"))
	hl.bind(key.BACKSPACE, hl.dsp.submap("reset"))
	hl.bind("CTRL + " .. key.C, hl.dsp.submap("reset"))
end)
