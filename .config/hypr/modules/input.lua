-----------------------------------------------------------
--  HACK: Input
-----------------------------------------------------------

hl.config({
	input = {
		kb_layout = "us, ara",
		numlock_by_default = true,
		resolve_binds_by_sym = true,
		sensitivity = 0.3,
		accel_profile = "flat",
		scroll_method = "2fg",
		scroll_factor = 0.5,
		follow_mouse = 1,

		touchpad = {
			natural_scroll = true,
			scroll_factor = 0.5,
			tap_button_map = "lrm",
			clickfinger_behavior = true,
		},
	},
})

--  INFO: Dell touchpad ---
hl.device({
	name = "dell08b8:00-0488:121f-touchpad",
	sensitivity = 1,
	enabled = true,
})
