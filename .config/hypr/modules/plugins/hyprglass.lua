-----------------------------------------------------------
--  HACK: Hyprbars
-----------------------------------------------------------

local colors = require("modules.colors")
local hg = hl.plugin.hyprglass

hg.config({
	enabled = true,
	default_theme = "dark",
	default_preset = "glass",
	layers = { enabled = true },
})

-- Layer surfaces: each call whitelists the namespace and configures it
hg.layer("waybar", { preset = "subtle", mask_threshold = 0.05 })
hg.layer("swaync")
hg.layer("quickshell:bezel", { preset = "ui", mask_threshold = 0.3 })
hg.layer("debug-panel", { exclude = true })

-- Presets
hg.preset("clear", {
	glass_opacity = 0.8,
	blur_strength = 1.0,
	dark = { brightness = 0.82 },
	light = { brightness = 1.2 },
})

hg.preset("contrasted", {
	inherits = "high_contrast",
	contrast = 1.2,
	adaptive_dim = 1.0,
	dark = { tint_color = 0x02142aa9 },
})

local function tint(c, alpha)
	return tonumber(c:match("%x%x%x%x%x%x"), 16) * 256 + math.floor(alpha * 255 + 0.5)
end

hg.preset("glass", {
	blur_strength = 2.0,
	blur_iterations = 3,
	chromatic_aberration = 0.2,
	fresnel_strength = 1,
	edge_thickness = 0.05,
	tint_color = tint(colors.dark5, 0.12),
	lens_distortion = 0.01,
	brightness = 1.0,
	contrast = 1.7,
	saturation = 1,
	vibrancy = 5,
	vibrancy_darkness = 1.7,
	adaptive_boost = 0.2,
})

hg.preset("apple", {
	blur_strength = 2.2,
	blur_iterations = 3,
	refraction_strength = 0.55,
	chromatic_aberration = 0.3,
	fresnel_strength = 0.5,
	specular_strength = 0.75,
	edge_thickness = 0.05,
	lens_distortion = 0.3,
	dark = { brightness = 0.82, contrast = 0.90, saturation = 0.80, vibrancy = 0.15, adaptive_dim = 0.4 },
	light = { brightness = 1.12, contrast = 0.92, saturation = 0.85, vibrancy = 0.12, adaptive_boost = 0.4 },
})
