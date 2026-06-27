-----------------------------------------------------------
--  HACK: Hyprbars
-----------------------------------------------------------

local colors = require("modules.colors")
local defaults = require("modules.defaults")

hl.config({
	plugin = {
		hyprbars = {
			bar_height = 35,
			bar_color = colors.dark6,
			["col.text"] = colors.fg,
			bar_text_size = 16,
			bar_text_font = "SF Pro Rounded",
			bar_button_padding = 10,
			bar_text_weight = "medium",
			bar_padding = 12,
			bar_precedence_over_border = true,
			bar_part_of_window = true,
			bar_text_align = "center",
			bar_buttons_alignment = "left",
			bar_blur = defaults.isBlur,
			on_double_click = "hyprctl dispatch 'hl.dsp.window.float()'",
			inactive_button_color = colors.dark1,
			icon_on_hover = true,
		},
	},
})

hl.plugin.hyprbars.add_button({
	bg_color = colors.red5,
	fg_color = colors.red9,
	size = 17,
	icon = "",
	action = "hyprctl dispatch 'hl.dsp.window.close()'",
})

hl.plugin.hyprbars.add_button({
	bg_color = colors.orange5,
	fg_color = colors.orange9,
	size = 17,
	icon = "󰘖",
	action = "hyprctl dispatch 'hl.dsp.window.fullscreen()'",
})

hl.plugin.hyprbars.add_button({
	bg_color = colors.yellow5,
	fg_color = colors.yellow9,
	size = 17,
	icon = "",
	action = "hyprctl dispatch 'hl.dsp.window.float()'",
})
