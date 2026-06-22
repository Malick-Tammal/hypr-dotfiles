-----------------------------------------------------------
--  HACK: Dynamic cursors
-----------------------------------------------------------

hl.config({
	plugin = {
		dynamic_cursors = {
			enabled = true,
			mode = "tilt",
			threshold = 2,

			rotate = {
				length = 20,
				offset = 0.0,
			},

			tilt = {
				limit = 2000,
				activation = "negative_quadratic",
				window = 100,
				full = 50,
			},

			shake = {
				enabled = true,
				threshold = 6.0,
				base = 3.0,
				speed = 4.0,
				influence = 0.0,
				limit = 0.0,
				timeout = 1000,
				effects = true,
				ipc = false,
			},

			hyprcursor = {
				nearest = 1,
				enabled = true,
				resolution = -1,
				fallback = "clientside",
			},
		},
	},
})
