-----------------------------------------------------------
--  HACK: Group
-----------------------------------------------------------
local colors = require("modules.colors")

hl.config({
	group = {
		["col.border_active"] = colors.green5,
		["col.border_inactive"] = colors.green7,
		["col.border_locked_active"] = colors.red5,
		["col.border_locked_inactive"] = colors.red7,

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
			["col.active"] = colors.green5,
			["col.inactive"] = colors.green7,
			text_color = colors.green9,
			text_color_inactive = colors.green3,
			gaps_in = 5,
			gaps_out = 5,
		},
	},
})
