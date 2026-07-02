-----------------------------------------------------------
--  HACK: Functions
-----------------------------------------------------------
local M = {}

local touchpad_name = "dell08b8:00-0488:121f-touchpad"

local function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

function M.notify(title, message, icon)
	local cmd = string.format("notify-send -u low -i '%s' '%s' '%s' -a 'Hyprland'", icon, title, message)
	hl.exec_cmd(cmd)
end

--  INFO: Toggle touchapd
if file_exists("/tmp/hypr_touchpad_disabled") then
	hl.device({
		name = touchpad_name,
		enabled = false,
	})
end

function M.toggle_touchpad()
	if file_exists("/tmp/hypr_touchpad_disabled") then
		os.remove("/tmp/hypr_touchpad_disabled")
		hl.device({
			name = touchpad_name,
			enabled = true,
		})
		M.notify("Touchpad", "Enabled", "input-touchpad-on")
	else
		os.execute("touch /tmp/hypr_touchpad_disabled")
		hl.device({
			name = touchpad_name,
			enabled = false,
		})
		M.notify("Touchpad", "Disabled", "input-touchpad-off")
	end
end

--  INFO: Toggle game mode
local game_mode_settings = {
	general = { gaps_in = 0, gaps_out = 0, border_size = 0 },
	animations = { enabled = false },
	decoration = {
		rounding = 0,
		blur = { enabled = false },
		shadow = { enabled = false },
	},
	plugin = {
		hyprbars = { enabled = false },
		dynamic_cursors = { enabled = false },
	},
}

if file_exists("/tmp/hypr_game_mode") then
	hl.config(game_mode_settings)
	hl.exec_cmd("killall -STOP hypridle 2>/dev/null")
end

function M.toggle_game_mode()
	if file_exists("/tmp/hypr_game_mode") then
		os.remove("/tmp/hypr_game_mode")

		if not file_exists("/tmp/hypr_caffeine") then
			hl.exec_cmd("killall -CONT hypridle 2>/dev/null")
		end

		hl.exec_cmd("hyprctl reload")
		M.notify("Game Mode", "Disabled", "preferences-desktop-gaming")
	else
		os.execute("touch /tmp/hypr_game_mode")
		hl.exec_cmd("killall -STOP hypridle 2>/dev/null")

		hl.config(game_mode_settings)

		hl.exec_cmd("hyprpm reload")
		M.notify("Game Mode", "Enabled", "preferences-desktop-gaming")
	end
end

--  INFO: Toggle caffeine
if file_exists("/tmp/hypr_caffeine") then
	hl.exec_cmd("killall -STOP hypridle 2>/dev/null")
end

function M.toggle_caffeine()
	local icon = "/usr/share/icons/Colloid-Yellow-Dark/status/symbolic/budgie-caffeine-cup-full.svg"

	if file_exists("/tmp/hypr_caffeine") then
		os.remove("/tmp/hypr_caffeine")

		if not file_exists("/tmp/hypr_game_mode") then
			hl.exec_cmd("killall -CONT hypridle 2>/dev/null")
		end

		M.notify("Caffeine Mode", "Disabled", icon)
	else
		os.execute("touch /tmp/hypr_caffeine")
		hl.exec_cmd("killall -STOP hypridle 2>/dev/null")
		M.notify("Caffeine Mode", "Enabled", icon)
	end
end

return M

