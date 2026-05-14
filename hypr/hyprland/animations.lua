hl.curve("easeInQuad",     { type = "bezier", points = { {1.11, 0.00}, {0.50, 0.00} } })
hl.curve("easeOutQuad",    { type = "bezier", points = { {0.50, 1.00}, {0.89, 1.00} } })
hl.curve("easeInCubic",    { type = "bezier", points = { {0.32, 0.00}, {0.67, 0.00} } })
hl.curve("easeOutCubic",   { type = "bezier", points = { {0.33, 1.00}, {0.68, 1.00} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.00}, {0.35, 1.00} } })
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.22, 1.00}, {0.36, 1.00} } })
hl.curve("easeInExpo",     { type = "bezier", points = { {0.70, 0.00}, {0.84, 0.00} } })
hl.curve("easeOutExpo",    { type = "bezier", points = { {0.16, 1.00}, {0.30, 1.00} } })
hl.curve("easeOutBack",    { type = "bezier", points = { {0.34, 1.56}, {0.64, 1.00} } })
hl.curve("bounce1",        { type = "bezier", points = { {0.18, 0.89}, {0.32, 0.87} } })
hl.curve("bounce2",        { type = "bezier", points = { {0.47, 1.64}, {0.41, 0.80} } })

hl.curve("easy",           { type = "spring", mass = 1, stiffness = 67, dampening = 12 })

hl.animation({ leaf = "global",        enabled = false, speed = 0,   bezier = "easeInOutCubic" })
hl.animation({ leaf = "border",        enabled = true,  speed = 4.5, bezier = "easeOutExpo" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 2.3, bezier = "easeOutCubic",   style = "slide" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 2.3, bezier = "easeOutCubic",   style = "slide" })
hl.animation({ leaf = "windowsMove",   enabled = true,  speed = 1.5, bezier = "easeOutCubic",   style = "slide" })

hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.0, bezier = "easeInCubic" })

hl.animation({ leaf = "layersIn",      enabled = true,  speed = 2.2, spring = "easy",           style = "slide" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.2, bezier = "easeInQuad",     style = "slide" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.6, bezier = "easeInQuad" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.8, bezier = "easeOutQuad" })

hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.7, bezier = "easeInOutCubic", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.7, bezier = "easeInOutCubic", style = "slide" })
