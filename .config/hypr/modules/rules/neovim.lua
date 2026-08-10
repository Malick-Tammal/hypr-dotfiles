-----------------------------------------------------------
--  HACK: Neovim (Adaptive border color)
-----------------------------------------------------------

local theme = require("modules.theme")

hl.window_rule({
	name = "neovim-normal",
	match = { class = "kitty", title = [[.*(nvim-normal).*]] },
	border_color = theme.colors.primary,
})

hl.window_rule({
	name = "neovim-insert",
	match = { class = "kitty", title = [[.*(nvim-insert).*]] },
	border_color = theme.colors.success,
})

hl.window_rule({
	name = "neovim-visual",
	match = { class = "kitty", title = [[.*(nvim-visual).*]] },
	border_color = theme.colors.info,
})

hl.window_rule({
	name = "neovim-replace",
	match = { class = "kitty", title = [[.*(nvim-replace).*]] },
	border_color = theme.colors.error,
})
