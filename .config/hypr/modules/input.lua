-----------------------------------------------------------
--  HACK: Input
-----------------------------------------------------------

hl.config({
	input = {
		kb_layout = "us, ara",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		kb_file = "",
		numlock_by_default = true,
		resolve_binds_by_sym = true,
		repeat_rate = 25,
		repeat_delay = 600,
		sensitivity = 0.3,
		accel_profile = "flat",
		force_no_accel = false,
		rotation = 0,
		left_handed = false,
		scroll_points = "",
		scroll_method = "2fg",
		scroll_button = 0,
		scroll_button_lock = false,
		scroll_factor = 0.5,
		follow_mouse = 0,
		follow_mouse_shrink = 0,
		follow_mouse_threshold = 0.0,
		focus_on_close = 0,
		mouse_refocus = true,
		float_switch_override_focus = 1,
		special_fallthrough = false,
		off_window_axis_events = 1,
		emulate_discrete_scroll = 1,

		touchpad = {
			disable_while_typing = true,
			natural_scroll = true,
			scroll_factor = 0.5,
			middle_button_emulation = false,
			tap_button_map = "lrm",
			clickfinger_behavior = true,
			tap_to_click = true,
			drag_lock = 0,
			tap_and_drag = true,
			flip_x = false,
			flip_y = false,
			drag_3fg = 0,
		},
	},
})

--  INFO: Dell touchpad ---
hl.device({
	name = "dell08b8:00-0488:121f-touchpad",
	sensitivity = 1,
	enabled = true,
})
