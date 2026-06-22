-----------------------------------------------------------
--  HACK: Gestures
-----------------------------------------------------------

hl.gesture({
	fingers = 3,
	direction = "swipe",
	action = "move",
})

hl.gesture({
	fingers = 3,
	direction = "down",
	mods = "SUPER",
	action = "close",
})

hl.gesture({
	fingers = 3,
	direction = "up",
	mods = "SUPER",

	action = function()
		hl.exec_cmd("kitty")
	end,
})

hl.gesture({
	fingers = 4,
	direction = "up",
	action = "fullscreen",
})

hl.gesture({
	fingers = 4,
	direction = "down",
	action = "float",
})
