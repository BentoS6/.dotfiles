-- Hyprland config

--------------------------------------------------------------------------------
--  Monitors
--------------------------------------------------------------------------------

hl.monitor({ output = "eDP-1", mode = "2560x1600@165", position = "0x0", scale = "1.3333" })

--------------------------------------------------------------------------------
--  Programs
--------------------------------------------------------------------------------

local home        = os.getenv("HOME")
local scripts     = home .. "/.config/hypr/scripts"
local terminal    = "kitty"
local fileManager = "nautilus"
local menu        = "rofi -show drun"
local fetch       = 'kitty --hold -e zsh -c "neofetch"'
local anki        = "net.ankiweb.Anki"
local browser     = "firefox"

--------------------------------------------------------------------------------
--  Autostart
--------------------------------------------------------------------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("dunst")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd(fetch)
    hl.exec_cmd("hypridle")
    hl.exec_cmd("poweralertd")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd(scripts .. "/internship_daily.sh")
end)

--------------------------------------------------------------------------------
--  Environment variables
--------------------------------------------------------------------------------

hl.env("XCURSOR_SIZE",        "24")
hl.env("HYPRCURSOR_SIZE",     "24")
hl.env("XDG_MENU_PREFIX",     "arch-")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("GTK_THEME", "Adwaita-dark")

--------------------------------------------------------------------------------
--  Window rules
--------------------------------------------------------------------------------

local floatingUtils = {
    { name = "float-dolphin",     class = "dolphin",                      size = "800 850" },
    { name = "float-anki",        class = "net.ankiweb.Anki",             size = "800 850" },
    { name = "float-blueman",     class = "blueman-manager",              size = "800 600" },
    { name = "float-nm-editor",   class = "nm-connection-editor",         size = "800 600" },
    { name = "float-pavucontrol", class = "org.pulseaudio.pavucontrol",   size = "800 600" },
}

for _, w in ipairs(floatingUtils) do
    hl.window_rule({
        name  = w.name,
        match = { class = w.class },

        float = true,
        pin   = true,
        size  = w.size,
    })
end

hl.window_rule({
    name        = "no-border-single-window",
    match       = { float = false, workspace = "w[tv1]" },

    border_size = 0,
})

hl.window_rule({
    name        = "no-border-fullscreen",
    match       = { float = false, workspace = "f[1]" },

    border_size = 0,
})

hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
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

--------------------------------------------------------------------------------
--  Look and feel
--------------------------------------------------------------------------------

--  centers all spawned child windows
hl.window_rule({ match = { float = true }, center = true })

hl.config({
    general = {
        gaps_in     = 0,
        gaps_out    = 0,
        border_size = 2,

        col = {
            active_border   = "rgb(ebdbb2)",
            inactive_border = "rgb(1B1B1B)",
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 5,
        rounding_power = 1, 
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true, 
        },

    master = {
        new_status = "master",
    },

    misc = {
        disable_hyprland_logo = true,
    },
})

--------------------------------------------------------------------------------
--  XWayland
--------------------------------------------------------------------------------

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

hl.curve("myBezier", { type = "bezier", points = { { 0.10, 0.9 }, { 0.1, 1 } } })

hl.animation({ leaf = "windows",    enabled = true, speed = 5,  bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5,  bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "border",     enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4,  bezier = "default" })

--------------------------------------------------------------------------------
--  Input
--------------------------------------------------------------------------------

hl.config({
    input = {
        kb_layout  = "us,jp",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

--------------------------------------------------------------------------------
--  Keybinds
--------------------------------------------------------------------------------

local mainMod = "SUPER"

-- lid open close
hl.bind("switch:on:Lid Switch",  hl.dsp.exec_cmd("hyprlock --immediate"), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("hyprlock --immediate"), { locked = true })

-- Apps
hl.bind(mainMod .. " + F",     hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + E",     hl.dsp.exec_cmd(browser))
hl.bind("CTRL + SHIFT + P",    hl.dsp.exec_cmd(browser .. " -private-window"))
hl.bind(mainMod .. " + A",     hl.dsp.exec_cmd(anki))
hl.bind(mainMod .. " + T",     hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind("XF86Bluetooth",       hl.dsp.exec_cmd("blueman-manager"))

-- Window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + S", hl.dsp.layout("togglesplit"))                   -- moved off J (hjkl focus)
hl.bind(mainMod .. " + SHIFT + semicolon", hl.dsp.exec_cmd("hyprlock"))    -- moved off L (hjkl focus)

-- Media playback
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("playerctl next"))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd("playerctl previous"))

-- Kill and restart waybar
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(scripts .. "/restart.sh")) -- moved off K (hjkl focus)

-- Screenshots
hl.bind(mainMod .. " + SHIFT + S",
    hl.dsp.exec_cmd("grimblast --freeze copysave area " ..
        home .. "/me_meow/pics/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"))

-- Move focus (arrows + hjkl)
local directions = {
    { key = "left",  vim = "H", dir = "left",  dx = -1, dy =  0 },
    { key = "down",  vim = "J", dir = "down",  dx =  0, dy =  1 },
    { key = "up",    vim = "K", dir = "up",    dx =  0, dy = -1 },
    { key = "right", vim = "L", dir = "right", dx =  1, dy =  0 },
}

local resizeStep = 40 -- px per press

for _, d in ipairs(directions) do
    hl.bind(mainMod .. " + " .. d.key, hl.dsp.focus({ direction = d.dir }))
    hl.bind(mainMod .. " + " .. d.vim, hl.dsp.focus({ direction = d.dir }))

    hl.bind(mainMod .. " + SHIFT + " .. d.vim,
        hl.dsp.window.resize({
            x        = d.dx * resizeStep,
            y        = d.dy * resizeStep,
            relative = true,
        }),
        { repeating = true })
end

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + I",          hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + O",          hl.dsp.focus({ workspace = "r+1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(scripts .. "/volume_notify.sh 5%+"),    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(scripts .. "/volume_notify.sh 5%-"),    { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(scripts .. "/volume_notify.sh toggle"), { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(scripts .. "/brightness_notify.sh 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(scripts .. "/brightness_notify.sh 10%-"), { locked = true, repeating = true })

-- Media keys
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })