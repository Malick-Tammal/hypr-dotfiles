-----------------------------------------------------------
--  HACK: Master
-----------------------------------------------------------

hl.define_submap("master_layout", function()
	hl.bind("L", hl.dsp.layout("mfact +0.02"), { repeating = true })
	hl.bind("H", hl.dsp.layout("mfact -0.02"), { repeating = true })
	hl.bind("S", hl.dsp.layout("swapwithmaster"))

	hl.bind("V", hl.dsp.window.float())
	hl.bind("SHIFT + F", hl.dsp.window.fullscreen())

	--  TIP: Exit submap
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("Backspace", hl.dsp.submap("reset"))
	hl.bind("CTRL + C", hl.dsp.submap("reset"))
end)
