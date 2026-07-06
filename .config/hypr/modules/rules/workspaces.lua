-----------------------------------------------------------
--  INFO: Workspaces
-----------------------------------------------------------

hl.workspace_rule({
	workspace = "special:Terminal",
	on_created_empty = "kitty",
})

hl.workspace_rule({
	workspace = "special:Android",
	on_created_empty = "waydroid show-full-ui",
})

hl.workspace_rule({
	workspace = "6",
	layout = "dwindle",
})

hl.workspace_rule({
	workspace = "7",
	layout = "master",
})
