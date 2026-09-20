---@module 'hl'

-- Monitors
hl.monitor({
    output   = "DP-1",
    mode     = "2560x1440@180",
    position = "0x0",
    scale    = 1.25,
})

-- 2560 / 1.25 = 2048 — no left/right position option, so stack horizontally
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@144",
    position = "2048x0",
    scale    = 1,
})

-- Programs
local terminal = "ghostty"
local fileManager = "nautilus"

-- Environment
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)

-- Look and feel
hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 3,
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
        col = {
            active_border = { colors = { "rgba(A7C080ee)", "rgba(7FBBB3ee)" }, angle = 45 },
            inactive_border = "rgba(475258aa)",
        },
    },
})

hl.config({
    decoration = {
        rounding = 8,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
})

-- Animations
hl.config({ animations = { enabled = true } })

hl.curve("snap",   { type = "bezier", points = { {0.19, 1},    {0.22, 1}    } }) -- fast ease-out, snappy decel
hl.curve("spring", { type = "bezier", points = { {0.05, 0.9},  {0.1, 1.05}  } }) -- gentle overshoot then settle
hl.curve("linear", { type = "bezier", points = { {1, 1},       {0, 0}       } }) -- constant rate (border rotation)

hl.animation({ leaf = "windowsIn",        enabled = true, speed = 2.5, bezier = "spring", style = "popin 85%" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 2,   bezier = "snap",   style = "popin 85%" })
hl.animation({ leaf = "windowsMove",      enabled = true, speed = 2,   bezier = "snap" })
hl.animation({ leaf = "border",           enabled = true, speed = 3,   bezier = "default" })
hl.animation({ leaf = "borderangle",      enabled = true, speed = 40,  bezier = "linear", style = "loop" })
hl.animation({ leaf = "fade",             enabled = true, speed = 2.5, bezier = "snap" })
hl.animation({ leaf = "fadeDim",          enabled = true, speed = 2.5, bezier = "snap" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 3,   bezier = "spring", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3,   bezier = "spring", style = "slidevert" })
hl.animation({ leaf = "layers",           enabled = true, speed = 2,   bezier = "snap",   style = "slide" })

-- Layouts
hl.config({
    dwindle = { preserve_split = true },
    master = { new_status = "master" },
})

hl.config({
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = true,
    },
})

-- Input
hl.config({
    input = {
        kb_layout = "us",
        kb_options = "ctrl:nocaps",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = { natural_scroll = true },
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Keybindings
local mainMod = "SUPER"
local altMod = "ALT"

local function key(...)
    return table.concat({ ... }, " + ")
end

-- Essentials
hl.bind(key(mainMod, "Q"), hl.dsp.window.close())
hl.bind(key(mainMod, "SHIFT", "E"), hl.dsp.exec_cmd("hyprshutdown"))
hl.bind(key(mainMod, "SHIFT", "Q"), hl.dsp.exec_cmd("hyprlock"))

-- Launchers
hl.bind(key(mainMod, "return"), hl.dsp.exec_cmd(terminal))
hl.bind(key(mainMod, "B"), hl.dsp.exec_cmd("flatpak run app.zen_browser.zen"))
hl.bind(key(mainMod, "E"), hl.dsp.exec_cmd(fileManager))
hl.bind(key(mainMod, "D"), hl.dsp.exec_cmd([[app=$(tofi-drun) && [ -n "$app" ] && sh -c "$app"]]))

-- Clipboard & screenshots
hl.bind(key(mainMod, "V"), hl.dsp.exec_cmd("~/go/bin/cliphist list | tofi --prompt-text 'cliphist: ' | ~/go/bin/cliphist decode | wl-copy"))
hl.bind("Print", hl.dsp.exec_cmd("grimblast copy area"))
hl.bind(key(mainMod, "Print"), hl.dsp.exec_cmd("grimblast copy active"))
hl.bind(key(altMod, "Print"), hl.dsp.exec_cmd("grimblast save area"))

-- Window state
hl.bind(key(mainMod, "F"), hl.dsp.window.float())
hl.bind(key(mainMod, "P"), hl.dsp.window.pseudo())
hl.bind(key(mainMod, "T"), hl.dsp.layout("togglesplit"))

-- Focus
hl.bind(key(mainMod, "H"), hl.dsp.focus({ direction = "left" }))
hl.bind(key(mainMod, "L"), hl.dsp.focus({ direction = "right" }))
hl.bind(key(mainMod, "K"), hl.dsp.focus({ direction = "up" }))
hl.bind(key(mainMod, "J"), hl.dsp.focus({ direction = "down" }))

-- Swap
hl.bind(key(mainMod, "SHIFT", "H"), hl.dsp.window.swap({ direction = "left" }))
hl.bind(key(mainMod, "SHIFT", "L"), hl.dsp.window.swap({ direction = "right" }))
hl.bind(key(mainMod, "SHIFT", "K"), hl.dsp.window.swap({ direction = "up" }))
hl.bind(key(mainMod, "SHIFT", "J"), hl.dsp.window.swap({ direction = "down" }))

-- Move into
hl.bind(key(altMod, "SHIFT", "H"), hl.dsp.window.move({ direction = "left" }))
hl.bind(key(altMod, "SHIFT", "L"), hl.dsp.window.move({ direction = "right" }))
hl.bind(key(altMod, "SHIFT", "K"), hl.dsp.window.move({ direction = "up" }))
hl.bind(key(altMod, "SHIFT", "J"), hl.dsp.window.move({ direction = "down" }))

-- Switch workspace
for ws = 1, 9 do
    hl.bind(key(mainMod, ws), hl.dsp.focus({ workspace = ws }))
end
hl.bind(key(mainMod, 0), hl.dsp.focus({ workspace = 10 }))

-- Move active window to workspace
for ws = 1, 9 do
    hl.bind(key(mainMod, "SHIFT", ws), hl.dsp.window.move({ workspace = ws }))
end
hl.bind(key(mainMod, "SHIFT", 0), hl.dsp.window.move({ workspace = 10 }))

-- Scratchpad
hl.bind(key(mainMod, "S"), hl.dsp.workspace.toggle_special("scratch"))
hl.bind(key(mainMod, "SHIFT", "S"), hl.dsp.window.move({ workspace = "special:scratch" }))

-- Scroll through workspaces
hl.bind(key(mainMod, "mouse_down"), hl.dsp.focus({ workspace = "e+1" }))
hl.bind(key(mainMod, "mouse_up"), hl.dsp.focus({ workspace = "e-1" }))

-- Mouse move/resize
hl.bind(key(mainMod, "mouse:272"), hl.dsp.window.drag(), { mouse = true })
hl.bind(key(mainMod, "mouse:273"), hl.dsp.window.resize(), { mouse = true })

-- Media keys (locked)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Window rules
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move = { 20, "monitor_h-120" },
    float = true,
})

-- Workspace rules
for ws = 1, 5 do
    hl.workspace_rule({ workspace = ws, monitor = "DP-1" })
end
for ws = 6, 10 do
    hl.workspace_rule({ workspace = ws, monitor = "HDMI-A-1" })
end

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE DISPLAY XAUTHORITY")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("nm-applet & blueman-applet &")
    hl.exec_cmd("waybar & hyprpaper &")
    hl.exec_cmd("wl-paste --type text --watch ~/go/bin/cliphist store")
    hl.exec_cmd("wl-paste --type image --watch ~/go/bin/cliphist store")
end)