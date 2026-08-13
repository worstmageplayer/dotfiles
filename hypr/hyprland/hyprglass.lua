if not hl.plugin.hyprglass then
    return
end

local hg = hl.plugin.hyprglass

hg.config({
    default_theme  = "dark",
    default_preset = "clear",

    tint_color = 0x00000000,

    brightness = 0.9,
    dark = { brightness = 1.0 },

    layers = { enabled = 1 },
})

hg.layer("rofi", { preset = "clearblur", mask_threshold = 0.05 })

hg.preset("clear", {
    glass_opacity        = 1.0,
    blur_strength        = 0.0,
    refraction_strength  = 0.9,
    chromatic_aberration = 0.4,
    lens_distortion      = 0.2,
    fresnel_strength     = 0.0,
    adaptive_dim         = 0.0,
    adaptive_boost       = 0.0,
})

hg.preset("clearblur", {
    glass_opacity        = 1.0,
    blur_strength        = 0.4,
    refraction_strength  = 1.2,
    chromatic_aberration = 0.7,
    lens_distortion      = 0.2,
    specular_strength    = 0.35,
    fresnel_strength     = 0.0,
    adaptive_dim         = 0.0,
    adaptive_boost       = 0.0,
    dark = { tint_color = 0x00000045}
})

hg.preset("clearterminal", {
    glass_opacity        = 1.0,
    blur_strength        = 0.7,
    refraction_strength  = 2.0,
    chromatic_aberration = 0.5,
    lens_distortion      = 1.0,
    specular_strength    = 0.7,
    fresnel_strength     = 0.0,
    saturation           = 1.0,
    vibrancy             = 0.0,
    adaptive_dim         = 0.0,
    adaptive_boost       = 0.0,
    dark = { tint_color = 0x16161d67}
})

hl.window_rule({ match = { class = "mpv" },            tag = "+hyprglass_disabled" })
hl.window_rule({ match = { class = "kitty" },          tag = "+hyprglass_preset_clearterminal" })
