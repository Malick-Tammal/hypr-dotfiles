-----------------------------------------------------------
--  HACK: Layers
-----------------------------------------------------------

local configs = require("modules.configs")

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
	name = "cornors",
	match = { namespace = "cornors" },
	no_anim = true,
})

hl.layer_rule({
	name = "rofi",
	match = { namespace = "rofi" },
	blur = configs.isBlur,
	ignore_alpha = 0.3,
})

hl.layer_rule({
	name = "swaync-control-center",
	match = { namespace = "swaync-control-center" },
	blur = configs.isBlur,
	ignore_alpha = 0.3,
})

hl.layer_rule({
	name = "swaync-notification-window",
	match = { namespace = "swaync-notification-window" },
	blur = configs.isBlur,
	ignore_alpha = 0.3,
})

hl.layer_rule({
	name = "swayosd",
	match = { namespace = "swayosd" },
	blur = configs.isBlur,
	ignore_alpha = 0.3,
})

hl.layer_rule({
	name = "waybar",
	match = { namespace = "waybar" },
	blur = configs.isBlur,
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
	name = "awww",
	match = { namespace = "awww-daemon" },
	no_anim = true,
})

hl.layer_rule({
	match = { namespace = "quickshell" },
	blur = configs.isBlur,
	ignore_alpha = 0.2,
})
