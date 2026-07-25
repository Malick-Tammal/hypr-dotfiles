-----------------------------------------------------------
--  HACK: Main plugins
-----------------------------------------------------------

if hl.plugin then
	if hl.plugin.hyprbars then
		require("modules.plugins.hyprbars")
	end

	if hl.plugin.dynamic_cursors then
		require("modules.plugins.dynamic-cursors")
	end

	if hl.plugin.hyprglass then
		require("modules.plugins.hyprglass")
	end
end
