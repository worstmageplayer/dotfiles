-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    mode     = "3200x2000@165",
    position = "0x0",
    scale    = "2.5",
})


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local menu        = "rofi -show drun -no-history -matching fuzzy -drun-match-fields name -no-tokenize"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
-- hl.on("hyprland.start", function ()
--   hl.exec_cmd(terminal)
--   hl.exec_cmd("nm-applet")
--   hl.exec_cmd("waybar & hyprpaper & firefox")
-- end)
hl.on("hyprland.start", function ()
  hl.exec_cmd("hyprpaper & waybar & hypridle")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic-Hyprcursor")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "12")
hl.env("AQ_DRM_DEVICES", "/dev/dri/intel-igpu:/dev/dri/nvidia-gpu")
hl.env("WLR_DRM_DEVICES", "/dev/dri/intel-igpu:/dev/dri/nvidia-gpu")
hl.env("GDK_SCALE", "2")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 2,
        gaps_out = 4,

        border_size = 2,

        col = {
            active_border   = "rgba(c9a2f0ee)",
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 5,
        rounding_power = 3,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = false,
        },

        blur = {
            enabled   = true,
            size      = 2,
            passes    = 4,
            contrast  = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeInQuad", { type = "bezier", points = { {1.11, 0.00}, {0.50, 0.00} } })
hl.curve("easeOutQuad", { type = "bezier", points = { {0.50, 1.00}, {0.89, 1.00} } })
hl.curve("easeInCubic", { type = "bezier", points = { {0.32, 0.00}, {0.67, 0.00} } })
hl.curve("easeOutCubic", { type = "bezier", points = { {0.33, 1.00}, {0.68, 1.00} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.00}, {0.35, 1.00} } })
hl.curve("easeOutQuint", { type = "bezier", points = { {0.22, 1.00}, {0.36, 1.00} } })
hl.curve("easeInExpo", { type = "bezier", points = { {0.70, 0.00}, {0.84, 0.00} } })
hl.curve("easeOutExpo", { type = "bezier", points = { {0.16, 1.00}, {0.30, 1.00} } })
hl.curve("easeOutBack", { type = "bezier", points = { {0.34, 1.56}, {0.64, 1.00} } })
hl.curve("bounce1", { type = "bezier", points = { {0.18, 0.89}, {0.32, 0.87} } })
hl.curve("bounce2", { type = "bezier", points = { {0.47, 1.64}, {0.41, 0.80} } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

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

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "ctrl:nocaps",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
        numlock_by_default = true,

        touchpad = {
            natural_scroll = true,
            scroll_factor  = 0.2
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "logitech-usb-receiver",
    sensitivity = -0.7,
    accel_profile = "flat",
})
hl.device({
    name        = "logitech-pro-x-2",
    sensitivity = -0.7,
    accel_profile = "flat",
})
hl.device({
    name        = "logitech-pro-x-2-1",
    sensitivity = -0.7,
    accel_profile = "flat",
})
hl.device({
    name        = "logitech-pro-x-2-2",
    sensitivity = -0.7,
    accel_profile = "flat",
})
hl.device({
    name        = "elan06fa:00-04f3:3280-touchpad",
    sensitivity = 0.3,
    accel_profile = "flat",
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("firefox --kiosk --new-window web.whatsapp.com"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("librewolf"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("firefox --kiosk --new-window discord.com/channels/@me"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("firefox --kiosk --new-window instagram.com/direct/inbox"))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("firefox --kiosk --new-window instagram.com/reels"))
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("/home/shawn/dotfiles/scripts/screenshot.sh"))
hl.bind(mainMod .. " + T", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("firefox --kiosk --new-window x.com"))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + H",     hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J",     hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + K",     hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + L",     hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + H",     hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J",     hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + K",     hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + L",     hl.dsp.window.swap({ direction = "right" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + mouse:274", hl.dsp.window.float({ action = "toggle" }), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.layer_rule({
    name  = "rofi",
    match = { class = "rofi" },

    blur  = true,
    ignore_alpha = 0,
})

hl.workspace_rule({
    workspace = "2",
    on_created_empty = "zen-browser",
})
hl.window_rule({
  border_size = 0,
  match = {
    float = 0,
    workspace = "w[tv1]"
  },
})
hl.window_rule({
  name = "feh",
  match = { class = "feh" },
  float = true,
  center = true,
})
hl.window_rule({
  match = { class = "mpv" },
  float = true,
})
hl.window_rule({
  match = { class = "firefox" },
  fullscreen_state = "0 2",
})
hl.window_rule({
  match = { class = "negative:kitty" },
  no_blur = true,
})
hl.layer_rule({
  match = { namespace = "selection" },
  no_anim = true,
})
