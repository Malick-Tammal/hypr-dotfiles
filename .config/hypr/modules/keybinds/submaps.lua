-----------------------------------------------------------
--  HACK: Submaps
-----------------------------------------------------------

local defaults = require("modules.defaults")
local home = os.getenv("HOME")
local key = require("utils.keys")

-- INFO: Managers ---
hl.bind(defaults.mainMod .. " + " .. key.M, hl.dsp.submap("managers"))

hl.define_submap("managers", function()
	hl.bind(key.B, hl.dsp.exec_cmd(defaults.btManager))
	hl.bind(key.W, hl.dsp.exec_cmd(defaults.wifiManager))
	hl.bind(key.A, hl.dsp.exec_cmd(defaults.audioManager))

	--  TIP: Exit submap
	hl.bind(key.ESCAPE, hl.dsp.submap("reset"))
	hl.bind(key.BACKSPACE, hl.dsp.submap("reset"))
	hl.bind("CTRL + " .. key.C, hl.dsp.submap("reset"))
end)
------------------------------------------------------

-- INFO: Scratchpad ---
hl.bind(defaults.mainMod .. " + " .. key.GRAVE, hl.dsp.submap("scratchpad"))

hl.define_submap("scratchpad", function()
	hl.bind(key.GRAVE, hl.dsp.workspace.toggle_special("Magic"))
	hl.bind(key.EQUAL, hl.dsp.window.move({ workspace = "special:Magic", follow = false }))
	hl.bind(key.MINUS, hl.dsp.window.move({ workspace = "+0", follow = false }))

	hl.bind(key.T, hl.dsp.workspace.toggle_special("Terminal"))
	hl.bind(key.A, hl.dsp.workspace.toggle_special("Android"))

	--  TIP: Exit submap
	hl.bind(key.ESCAPE, hl.dsp.submap("reset"))
	hl.bind(key.BACKSPACE, hl.dsp.submap("reset"))
	hl.bind("CTRL + " .. key.C, hl.dsp.submap("reset"))
end)
------------------------------------------------------

-- INFO: Screenshot utility ---
hl.bind(defaults.mainMod .. " + " .. key.S, hl.dsp.submap("screenshot"))

hl.define_submap("screenshot", function()
	hl.bind(key.A, hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/screenshot.sh --area"))
	hl.bind(key.W, hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/screenshot.sh --window"))
	hl.bind(key.F, hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/screenshot.sh --full"))
	hl.bind(key.E, hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/screenshot.sh --edit"))
	hl.bind(key.O, hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/ocr.sh"))

	--  TIP: Exit submap
	hl.bind(key.ESCAPE, hl.dsp.submap("reset"))
	hl.bind(key.BACKSPACE, hl.dsp.submap("reset"))
	hl.bind("CTRL + " .. key.C, hl.dsp.submap("reset"))
end)
------------------------------------------------------

-- INFO: Development ---
hl.bind(defaults.mainMod .. " + " .. key.D, hl.dsp.submap("dev"))

hl.define_submap("dev", function()
	hl.bind(key.B, hl.dsp.exec_cmd("chromium"))
	hl.bind(key.C, hl.dsp.exec_cmd("code"))
	hl.bind(key.N, hl.dsp.exec_cmd(defaults.terminal .. " --class neovim --title 'Neovim' -e nvim"))
	hl.bind(key.F, hl.dsp.exec_cmd("figma-linux"))

	--  TIP: Exit submap
	hl.bind(key.ESCAPE, hl.dsp.submap("reset"))
	hl.bind(key.BACKSPACE, hl.dsp.submap("reset"))
	hl.bind("CTRL + " .. key.C, hl.dsp.submap("reset"))
end)
------------------------------------------------------

-- INFO: Group ---
hl.bind(defaults.mainMod .. " + " .. key.G, hl.dsp.submap("groups"))

hl.define_submap("groups", function()
	hl.bind(key.G, function()
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

	hl.bind(key.TAB, hl.dsp.group.next())
	hl.bind("SHIFT + " .. key.TAB, hl.dsp.group.prev())

	hl.bind(key.O, hl.dsp.window.move({ out_of_group = true }))

	hl.bind(defaults.mainMod .. " + " .. key.L, hl.dsp.focus({ direction = "right" }))
	hl.bind(defaults.mainMod .. " + " .. key.H, hl.dsp.focus({ direction = "left" }))
	hl.bind(defaults.mainMod .. " + " .. key.K, hl.dsp.focus({ direction = "up" }))
	hl.bind(defaults.mainMod .. " + " .. key.J, hl.dsp.focus({ direction = "down" }))

	hl.bind(defaults.mainModShift .. " + " .. key.L, hl.dsp.window.move({ direction = "right" }))
	hl.bind(defaults.mainModShift .. " + " .. key.H, hl.dsp.window.move({ direction = "left" }))
	hl.bind(defaults.mainModShift .. " + " .. key.K, hl.dsp.window.move({ direction = "up" }))
	hl.bind(defaults.mainModShift .. " + " .. key.J, hl.dsp.window.move({ direction = "down" }))

	hl.bind(key.H, hl.dsp.window.move({ into_group = "l" }))
	hl.bind(key.L, hl.dsp.window.move({ into_group = "r" }))
	hl.bind(key.K, hl.dsp.window.move({ into_group = "u" }))
	hl.bind(key.J, hl.dsp.window.move({ into_group = "d" }))

	--  TIP: Exit submap
	hl.bind(key.ESCAPE, hl.dsp.submap("reset"))
	hl.bind(key.BACKSPACE, hl.dsp.submap("reset"))
	hl.bind("CTRL + " .. key.C, hl.dsp.submap("reset"))
end)
------------------------------------------------------
