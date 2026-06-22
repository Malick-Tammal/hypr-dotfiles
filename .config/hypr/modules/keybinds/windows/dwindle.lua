--------------------------------------------------------
--  HACK: Dwindle
--------------------------------------------------------

hl.define_submap("dwindle_layout", function()
	hl.bind("F", hl.dsp.window.fullscreen())

	hl.bind("L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
	hl.bind("H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

	hl.bind("V", hl.dsp.window.float())
	hl.bind("S", hl.dsp.layout("togglesplit"))

	--  TIP: Exit submap
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("Backspace", hl.dsp.submap("reset"))
	hl.bind("CTRL + C", hl.dsp.submap("reset"))
end)
