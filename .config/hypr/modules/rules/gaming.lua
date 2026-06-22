-----------------------------------------------------------
--  HACK: Gaming
-----------------------------------------------------------

hl.window_rule({
	name = "gaming-1",
	match = { title = [[^(.*\.exe)$]] },
	immediate = true,
})

hl.window_rule({
	name = "gaming-2",
	match = { class = [[^(steam_app).*$]] },
	immediate = true,
})

hl.window_rule({
	name = "counter-strike 2",
	match = { class = [[^(cs2).*$]] },
	immediate = true,
})

hl.window_rule({
	name = "half-life and cs 1.6",
	match = { class = [[^(hl_linux).*$]] },
	immediate = true,
})

hl.window_rule({
	name = "steam",
	match = { class = "steam" },
})
