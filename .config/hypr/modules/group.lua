-----------------------------------------------------------
--  HACK: Group
-----------------------------------------------------------
local theme = require("modules.theme")

hl.config({
	group = {
		["col.border_active"] = theme.colors.success,
		["col.border_inactive"] = theme.colors.successBorder,
		["col.border_locked_active"] = theme.colors.error,
		["col.border_locked_inactive"] = theme.colors.errorBorder,

		groupbar = {
			enabled = true,
			font_family = "SF Pro Rounded",
			font_size = 16,
			font_weight_active = "medium",
			font_weight_inactive = "medium",
			height = 1,
			indicator_height = 15,
			rounding = 10,
			text_offset = -6,
			["col.active"] = theme.colors.success,
			["col.inactive"] = theme.colors.successBorder,
			text_color = theme.colors.onSuccess,
			text_color_inactive = theme.colors.successContainer,
			gaps_in = 5,
			gaps_out = 5,
		},
	},
})
