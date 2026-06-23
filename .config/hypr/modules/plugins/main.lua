-----------------------------------------------------------
--  HACK: Main plugins
-----------------------------------------------------------

if hl.plugin ~= nil then
	if hl.plugin.hyprbars ~= nil then
		require("modules.plugins.hyprbars")
	end

	if hl.plugin.dynamic_cursors ~= nil then
		require("modules.plugins.dynamic-cursors")
	end
end
