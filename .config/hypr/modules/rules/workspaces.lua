-----------------------------------------------------------
--  INFO: Workspaces
-----------------------------------------------------------

hl.workspace_rule({
	workspace = "special:Terminal",
	on_created_empty = "kitty",
})

hl.workspace_rule({
	workspace = "special:Server",
	on_created_empty = "virt-manager",
})

hl.workspace_rule({
	workspace = "6",
	layout = "dwindle",
})

hl.workspace_rule({
	workspace = "7",
	layout = "master",
})
