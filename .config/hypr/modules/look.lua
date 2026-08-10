-----------------------------------------------------------
--  HACK: Look
-----------------------------------------------------------

local theme = require("modules.theme")
local configs = require("modules.configs")

hl.config({
	general = {
		border_size = 1,

		gaps_in = configs.gapsIn,
		gaps_out = configs.gapsOut,
		gaps_workspaces = 10,

		col = {
			active_border = { colors = { theme.colors.border, theme.colors.borderAlt }, angle = 45 },
			inactive_border = theme.colors.borderDim,
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
			window_gap = configs.gapsOut,
			monitor_gap = configs.gapsOut,
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
			enabled = configs.blur,
			size = 6,
			passes = 5,
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
			color = theme.colors.warning,
			color_inactive = theme.colors.textMuted,
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
