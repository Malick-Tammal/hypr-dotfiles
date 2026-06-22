-----------------------------------------------------------
--  HACK: Look
-----------------------------------------------------------

local colors = require("modules.colors")
local defaults = require("modules.defaults")

hl.config({
	general = {
		border_size = 1,

		gaps_in = defaults.gapsIn,
		gaps_out = defaults.gapsOut,
		gaps_workspaces = 10,

		col = {
			active_border = { colors = { colors.orange5, colors.yellow5 }, angle = 45 },
			inactive_border = colors.dark1,
		},

		layout = "scrolling",
		no_focus_fallback = true,
		resize_on_border = true,
		extend_border_grab_area = 10,
		allow_tearing = true,
		resize_corner = 4,
		locale = "en_US",

		snap = {
			enabled = true,
			window_gap = defaults.gapsOut,
			monitor_gap = defaults.gapsOut,
			border_overlap = true,
			respect_gaps = true,
		},
	},

	decoration = {
		rounding = 15,
		rounding_power = 3,
		dim_strength = 0.3,
		dim_special = 0.3,
		dim_around = 0.4,

		blur = {
			enabled = defaults.blur,
			size = 6,
			passes = 3,
			noise = 0.055,
			contrast = 1,
			brightness = 1,
			vibrancy = 0.1696,
			vibrancy_darkness = 0.2,
			special = true,
			popups = true,
			popups_ignorealpha = 0.3,
			input_methods = true,
			input_methods_ignorealpha = 0.3,
		},

		shadow = {
			enabled = false,
		},

		glow = {
			enabled = false,
			range = 20,
			render_power = 2,
			color = colors.orange7,
			color_inactive = colors.dark1,
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		force_split = 2,
		preserve_split = true,
	},

	scrolling = {
		column_width = 0.8,
		explicit_column_widths = "0.8 , 1.0",
		direction = "right",
	},

	master = {
		allow_small_split = true,
		mfact = 0.6,
	},

	xwayland = {
		force_zero_scaling = true,
	},
})
