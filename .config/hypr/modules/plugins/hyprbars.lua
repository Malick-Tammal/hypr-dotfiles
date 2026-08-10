-----------------------------------------------------------
--  HACK: Hyprbars
-----------------------------------------------------------

local theme = require("modules.theme")
local configs = require("modules.configs")

hl.config({
	plugin = {
		hyprbars = {
			bar_height = 35,
			bar_color = theme.colors.surfaceContainer,
			["col.text"] = theme.colors.textPrimary,
			bar_text_size = 16,
			bar_text_font = "SF Pro Rounded",
			bar_button_padding = 10,
			bar_text_weight = "medium",
			bar_padding = 12,
			bar_precedence_over_border = true,
			bar_part_of_window = true,
			bar_text_align = "center",
			bar_buttons_alignment = "left",
			bar_blur = configs.isBlur,
			on_double_click = "hyprctl dispatch 'hl.dsp.window.float()'",
			inactive_button_color = theme.colors.textMuted,
			icon_on_hover = true,
		},
	},
})

hl.plugin.hyprbars.add_button({
	bg_color = theme.colors.error,
	fg_color = theme.colors.onError,
	size = 17,
	icon = "",
	action = "hyprctl dispatch 'hl.dsp.window.close()'",
})

hl.plugin.hyprbars.add_button({
	bg_color = theme.colors.warning,
	fg_color = theme.colors.onWarning,
	size = 17,
	icon = "󰘖",
	action = "hyprctl dispatch 'hl.dsp.window.fullscreen()'",
})

hl.plugin.hyprbars.add_button({
	bg_color = theme.colors.primary,
	fg_color = theme.colors.onPrimary,
	size = 17,
	icon = "",
	action = "hyprctl dispatch 'hl.dsp.window.float()'",
})
