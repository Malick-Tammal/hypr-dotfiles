-----------------------------------------------------------
--  HACK: Layers
-----------------------------------------------------------

local defaults = require("modules.defaults")

hl.layer_rule({
	name = "walli",
	match = { namespace = "walli" },
	dim_around = false,
})

hl.layer_rule({
	name = "powermenu",
	match = { namespace = "powermenu" },
	dim_around = false,
})

hl.layer_rule({
	name = "rofi",
	match = { namespace = "rofi" },
	blur = defaults.isBlur,
	ignore_alpha = 0.3,
})

hl.layer_rule({
	name = "swaync-control-center",
	match = { namespace = "swaync-control-center" },
	blur = defaults.isBlur,
	ignore_alpha = 0.3,
})

hl.layer_rule({
	name = "swaync-notification-window",
	match = { namespace = "swaync-notification-window" },
	blur = defaults.isBlur,
	ignore_alpha = 0.3,
})

hl.layer_rule({
	name = "swayosd",
	match = { namespace = "swayosd" },
	blur = defaults.isBlur,
	ignore_alpha = 0.3,
})

hl.layer_rule({
	name = "waybar",
	match = { namespace = "waybar" },
	blur = defaults.isBlur,
	ignore_alpha = 0.3,
})

hl.layer_rule({
	name = "slurp",
	match = { namespace = [[^(selection| slurp)$]] },
	no_anim = true,
})

hl.layer_rule({
	name = "hyprpicker",
	match = { namespace = "hyprpicker" },
	no_anim = true,
})

hl.layer_rule({
	name = "hyprpicker",
	match = { namespace = "awww-daemon" },
	no_anim = true,
})
