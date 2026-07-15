-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")
require("hyprland.animations")
require("hyprland.binds")
require("hyprland.environmentVariables")

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-2",
    mode     = "3200x2000@165",
    position = "0x0",
    scale    = "2",
})
hl.monitor({
    output   = "eDP-1",
    mode     = "3200x2000@165",
    position = "0x0",
    scale    = "2",
})

hl.config({
  xwayland = {
    force_zero_scaling = 1;
  }
})
-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function ()
  hl.exec_cmd("hyprpaper & quickshell & hypridle")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)

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

hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
    master = {
        new_status = "master",
    },
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

local sens = -0.6

hl.device({
    name        = "logitech-usb-receiver",
    sensitivity = sens,
    accel_profile = "flat",
})
hl.device({
    name        = "logitech-pro-x-2",
    sensitivity = sens,
    accel_profile = "flat",
})
hl.device({
    name        = "logitech-pro-x-2-1",
    sensitivity = sens,
    accel_profile = "flat",
})
hl.device({
    name        = "logitech-pro-x-2-2",
    sensitivity = sens,
    accel_profile = "flat",
})
hl.device({
    name        = "elan06fa:00-04f3:3280-touchpad",
    sensitivity = 0.3,
    accel_profile = "flat",
})

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

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
  match = { class = "librewolf" },
  workspace = "3 silent"
})
hl.window_rule({
  match = { class = "firefox" },
  workspace = "4 silent"
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
  match = { class = "org.gnome.Nautilus" },
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
  blur = false,
  no_anim = true,
})
