-----------------------------------------------------------
--  HACK: Misc
-----------------------------------------------------------
local colors = require("modules.colors")

hl.config({
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		["col.splash"] = colors.fg,
		font_family = "SF Pro Rounded",
		splash_font_family = "SF Pro Rounded",
		force_default_wallpaper = 0,
		vrr = 1,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		allow_session_lock_restore = true,
		session_lock_xray = true,
		background_color = colors.dark5,
	},

	render = {
		direct_scanout = 1,
	},
})
