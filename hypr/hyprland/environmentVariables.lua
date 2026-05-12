hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

hl.env("GDK_BACKEND", "wayland,x11,*")

hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic-Hyprcursor")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "12")
hl.env("AQ_DRM_DEVICES", "/dev/dri/intel-igpu:/dev/dri/nvidia-gpu")
hl.env("WLR_DRM_DEVICES", "/dev/dri/intel-igpu:/dev/dri/nvidia-gpu")
hl.env("GDK_SCALE", "2")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
