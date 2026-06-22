--------------------------------------------------------
--  HACK: Scrolling
--------------------------------------------------------

hl.define_submap("scrolling_layout", function()
	hl.bind("L", hl.dsp.layout("colresize +0.02"), { repeating = true })
	hl.bind("H", hl.dsp.layout("colresize -0.02"), { repeating = true })

	hl.bind("F", hl.dsp.layout("colresize +conf"))

	hl.bind("R", hl.dsp.layout("promote"))
	hl.bind("C", hl.dsp.layout("fit visible"))

	hl.bind("V", hl.dsp.window.float())
	hl.bind("SHIFT + F", hl.dsp.window.fullscreen())

	--  TIP: Exit submap
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("Backspace", hl.dsp.submap("reset"))
	hl.bind("CTRL + C", hl.dsp.submap("reset"))
end)
