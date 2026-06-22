-----------------------------------------------------------
--  HACK: Submaps
-----------------------------------------------------------

local defaults = require("modules.defaults")
local home = os.getenv("HOME")

-- INFO: Managers ---
hl.bind(defaults.mainMod .. " + M", hl.dsp.submap("managers"))

hl.define_submap("managers", function()
	hl.bind("B", hl.dsp.exec_cmd(defaults.btManager))
	hl.bind("W", hl.dsp.exec_cmd(defaults.wifiManager))
	hl.bind("A", hl.dsp.exec_cmd(defaults.audioManager))

	--  TIP: Exit submap
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("Backspace", hl.dsp.submap("reset"))
	hl.bind("CTRL + C", hl.dsp.submap("reset"))
end)
------------------------------------------------------

-- INFO: Scratchpad ---
hl.bind(defaults.mainMod .. " + Grave", hl.dsp.submap("scratchpad"))

hl.define_submap("scratchpad", function()
	hl.bind("Grave", hl.dsp.workspace.toggle_special("Magic"))
	hl.bind("equal", hl.dsp.window.move({ workspace = "special:Magic", follow = false }))
	hl.bind("minus", hl.dsp.window.move({ workspace = "+0", follow = false }))

	hl.bind("T", hl.dsp.workspace.toggle_special("Terminal"))
	hl.bind("A", hl.dsp.workspace.toggle_special("Android"))

	--  TIP: Exit submap
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("Backspace", hl.dsp.submap("reset"))
	hl.bind("CTRL + C", hl.dsp.submap("reset"))
end)
------------------------------------------------------

-- INFO: Screenshot utility ---
hl.bind(defaults.mainMod .. " + S", hl.dsp.submap("screenshot"))

hl.define_submap("screenshot", function()
	hl.bind("A", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/screenshot.sh --area"))
	hl.bind("W", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/screenshot.sh --window"))
	hl.bind("F", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/screenshot.sh --full"))
	hl.bind("E", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/screenshot.sh --edit"))
	hl.bind("O", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/ocr.sh"))

	--  TIP: Exit submap
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("Backspace", hl.dsp.submap("reset"))
	hl.bind("CTRL + C", hl.dsp.submap("reset"))
end)
------------------------------------------------------

-- INFO: Development ---
hl.bind(defaults.mainMod .. " + D", hl.dsp.submap("dev"))

hl.define_submap("dev", function()
	hl.bind("B", hl.dsp.exec_cmd("chromium"))
	hl.bind("C", hl.dsp.exec_cmd("code"))
	hl.bind("N", hl.dsp.exec_cmd(defaults.terminal .. " --class neovim --title 'Neovim' -e nvim"))
	hl.bind("F", hl.dsp.exec_cmd("figma-linux"))

	--  TIP: Exit submap
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("Backspace", hl.dsp.submap("reset"))
	hl.bind("CTRL + C", hl.dsp.submap("reset"))
end)
------------------------------------------------------

-- INFO: Group ---
hl.bind(defaults.mainMod .. " + G", hl.dsp.submap("group"))

hl.define_submap("group", function()
	hl.bind("G", function()
		local win = hl.get_active_window()

		if win == nil then
			return
		end

		if win.group ~= nil then
			hl.dispatch(hl.dsp.window.move({ out_of_group = "right" }))
		else
			hl.dispatch(hl.dsp.group.toggle())
		end
	end)

	hl.bind("Tab", hl.dsp.group.next())
	hl.bind("SHIFT + Tab", hl.dsp.group.prev())

	hl.bind("O", hl.dsp.window.move({ out_of_group = true }))

	hl.bind(defaults.mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
	hl.bind(defaults.mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
	hl.bind(defaults.mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
	hl.bind(defaults.mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

	hl.bind(defaults.mainModShift .. " + L", hl.dsp.window.move({ direction = "right" }))
	hl.bind(defaults.mainModShift .. " + H", hl.dsp.window.move({ direction = "left" }))
	hl.bind(defaults.mainModShift .. " + K", hl.dsp.window.move({ direction = "up" }))
	hl.bind(defaults.mainModShift .. " + J", hl.dsp.window.move({ direction = "down" }))

	hl.bind("H", hl.dsp.window.move({ into_group = "l" }))
	hl.bind("L", hl.dsp.window.move({ into_group = "r" }))
	hl.bind("K", hl.dsp.window.move({ into_group = "u" }))
	hl.bind("J", hl.dsp.window.move({ into_group = "d" }))

	--  TIP: Exit submap
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("Backspace", hl.dsp.submap("reset"))
	hl.bind("CTRL + C", hl.dsp.submap("reset"))
end)
------------------------------------------------------
