-----------------------------------------------------------
--  HACK: Colors
-----------------------------------------------------------
local configs = require("modules.configs")
local home = os.getenv("HOME")

local M = {}

local matugen = nil

if configs.matugenColors then
	local matugenFilePath = home .. "/.config/matugen/output/hyprland.lua"
	local file = io.open(matugenFilePath, "r")

	if file then
		file:close()
		local success, loaded = pcall(dofile, matugenFilePath)
		if success and type(loaded) == "table" then
			matugen = loaded
		end
	end
end

local monokai_fusion = {
	--  TIP: Dark
	dark7 = "#11120F",
	dark6 = "#171814",
	dark5 = "#1D1E19",
	dark4 = "#282922",
	dark3 = "#33342B",
	dark2 = "#3D4035",
	dark1 = "#606453",

	--  TIP: Yellow
	yellow9 = "#332B14",
	yellow8 = "#4C411F",
	yellow7 = "#99823D",
	yellow6 = "#CCAD52",
	yellow5 = "#FFD866",
	yellow4 = "#FFE085",
	yellow3 = "#FFE8A3",
	yellow2 = "#FFEFC2",
	yellow1 = "#FFF7E0",

	--  TIP: Orange
	orange9 = "#321E15",
	orange8 = "#5C3927",
	orange7 = "#975B3E",
	orange6 = "#CA7A52",
	orange5 = "#FC9867",
	orange4 = "#FDAD85",
	orange3 = "#FDC1A4",
	orange2 = "#FED6C2",
	orange1 = "#FEEAE1",

	--  TIP: Red
	red9 = "#33131B",
	red8 = "#662736",
	red7 = "#993A52",
	red6 = "#CC4E6D",
	red5 = "#FF6188",
	red4 = "#FF81A0",
	red3 = "#FFA0B8",
	red2 = "#FFC0CF",
	red1 = "#FDDDDD",

	--  TIP: Green
	green9 = "#222C18",
	green8 = "#44582F",
	green7 = "#658447",
	green6 = "#87B05E",
	green5 = "#A9DC76",
	green4 = "#BAE391",
	green3 = "#CBEAAD",
	green2 = "#DDF1C8",
	green1 = "#EEF8E4",

	--  TIP: Blue
	blue9 = "#182C2E",
	blue8 = "#30585D",
	blue7 = "#48848B",
	blue6 = "#60B0BA",
	blue5 = "#78DCE8",
	blue4 = "#93E3ED",
	blue3 = "#AEEAF1",
	blue2 = "#C9F1F6",
	blue1 = "#E4F8FA",

	--  TIP: Purple
	purple9 = "#2A234E",
	purple8 = "#4A4277",
	purple7 = "#6B60A0",
	purple6 = "#8B7FC9",
	purple5 = "#AB9DF2",
	purple4 = "#BCB1F5",
	purple3 = "#CDC4F7",
	purple2 = "#DDD8FA",
	purple1 = "#EEEBFC",
	white = "#FDFFF1",
}

M.colors = {
	background = (matugen and matugen.background) or monokai_fusion.dark5,
	surface = (matugen and matugen.surface) or monokai_fusion.dark4,
	surfaceDim = (matugen and matugen.surface_dim) or monokai_fusion.dark6,
	surfaceContainer = (matugen and matugen.surface_container) or monokai_fusion.dark6,

	textPrimary = (matugen and matugen.on_background) or monokai_fusion.white,
	textMuted = (matugen and matugen.outline) or monokai_fusion.dark1,

	primary = (matugen and matugen.primary) or monokai_fusion.yellow5,
	onPrimary = (matugen and matugen.on_primary) or monokai_fusion.yellow9,

	error = (matugen and matugen.error) or monokai_fusion.red5,
	onError = (matugen and matugen.on_error) or monokai_fusion.red9,
	errorBorder = (matugen and matugen.on_error_container) or monokai_fusion.red9,

	warning = (matugen and matugen.tertiary) or monokai_fusion.orange5,
	onWarning = (matugen and matugen.on_tertiary) or monokai_fusion.orange9,
	warningBorder = (matugen and matugen.on_tertiary_fixed_variant) or monokai_fusion.orange7,

	success = (matugen and matugen.secondary) or monokai_fusion.green5,
	onSuccess = (matugen and matugen.on_secondary) or monokai_fusion.green9,
	successBorder = (matugen and matugen.on_secondary_fixed_variant) or monokai_fusion.green7,
	successContainer = (matugen and matugen.on_secondary_container) or monokai_fusion.green3,

	info = (matugen and matugen.tertiary) or monokai_fusion.purple5,
	onInfo = (matugen and matugen.on_tertiary) or monokai_fusion.purple9,

	border = (matugen and matugen.primary) or monokai_fusion.yellow5,
	borderDim = (matugen and matugen.outline) or monokai_fusion.dark1,
	borderAlt = (matugen and matugen.secondary) or monokai_fusion.orange5,
}

return M
