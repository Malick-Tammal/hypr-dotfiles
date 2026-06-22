-----------------------------------------------------------
--  HACK: Neovim (Adaptive border color)
-----------------------------------------------------------

local colors = require("modules.colors")

hl.window_rule({
	name = "neovim-normal",
	match = { class = "kitty", title = [[.*(nvim-normal).*]] },
	border_color = colors.yellow5,
})

hl.window_rule({
	name = "neovim-insert",
	match = { class = "kitty", title = [[.*(nvim-insert).*]] },
	border_color = colors.green5,
})

hl.window_rule({
	name = "neovim-visual",
	match = { class = "kitty", title = [[.*(nvim-visual).*]] },
	border_color = colors.purple5,
})

hl.window_rule({
	name = "neovim-replace",
	match = { class = "kitty", title = [[.*(nvim-replace).*]] },
	border_color = colors.red5,
})
