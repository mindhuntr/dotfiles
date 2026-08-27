-- ███╗   ███╗██╗███╗   ██╗██████╗ ██╗  ██╗██╗   ██╗███╗   ██╗████████╗███████╗██████╗ 
-- ████╗ ████║██║████╗  ██║██╔══██╗██║  ██║██║   ██║████╗  ██║╚══██╔══╝██╔════╝██╔══██╗
-- ██╔████╔██║██║██╔██╗ ██║██║  ██║███████║██║   ██║██╔██╗ ██║   ██║   █████╗  ██████╔╝
-- ██║╚██╔╝██║██║██║╚██╗██║██║  ██║██╔══██║██║   ██║██║╚██╗██║   ██║   ██╔══╝  ██╔══██╗
-- ██║ ╚═╝ ██║██║██║ ╚████║██████╔╝██║  ██║╚██████╔╝██║ ╚████║   ██║   ███████╗██║  ██║
-- ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
--                                                                                     
-- dotfiles circa 2026

---@module 'hl'

-- Monitors 
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1 })
-- monitor = HDMI-A-1,preferred,auto,1,mirror,eDP-1

-- Envs 
-- hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "22")
-- hl.env("QT_QPA_PLATFORMTHEME", "qt5ct") -- change to qt6ct if you have that
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct") -- change to qt6ct if you have that
hl.env("GTK_THEME", "Catppuccin-purple")
hl.env("GTK_ICON_THEME", "Papirus-Dark")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_DESKTOP_PORTAL", "gtk")

-- Nvidia
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")


---- Autostart ----
hl.on("hyprland.start", function()
    hl.exec_cmd("dms run")
    hl.exec_cmd("systemctl --user start hyprpaper")
    hl.exec_cmd("systemctl --user start dark-send")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 22")
    hl.exec_cmd("mako")
    -- hl.exec_cmd("unclutter --timeout 1")
    hl.exec_cmd(os.getenv("HOME") .. "/.bin/read_time.sh")
    hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/battery_notify.sh")
    hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/battery_warning.sh")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("wl-paste --type text --watch cliphist store") -- Stores only text data
    hl.exec_cmd("wl-paste --type image --watch cliphist store") -- Stores only image data
    -- hl.exec_cmd("hyprpm reload") -- load plugins

    -- Startup applications
    hl.exec_cmd("zen-browser")
    hl.exec_cmd(os.getenv("HOME") .. "/Downloads/Telegram/Telegram")
    hl.exec_cmd("kitty --class weechat -e weechat")
end)

-- Vars
local HOME = os.getenv("HOME")
local terminal = "kitty --title Kitty"
local fileManager = "thunar"
local menu = "rofi"
local volume = "pactl set-sink-volume @DEFAULT_SINK@"
local brightness = "brightnessctl"
local iconpath = HOME .. "/.config/hypr/notify_icons"


-- General configuration
hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 0,
        touchpad = {
            natural_scroll = false,
        },
        sensitivity = 0,
        -- -1.0 to 1.0, 0 means no modification.
    },
})

hl.config({
    general = {
        gaps_in = 10,
        gaps_out = 10,
        border_size = 3,
        layout = "scrolling",
        allow_tearing = false,
        ["col.active_border"]   = "rgb(166,173,200)",
        ["col.inactive_border"] = "rgba(595959aa)",
    },
})


hl.config({
    cursor = {
        inactive_timeout = 2,
        hide_on_key_press = false,
    },
})

hl.config({
    decoration = {
        rounding = 10,
        blur = {
            enabled = true,
            size = 7,
            passes = 3,
            noise = 0.08,
            ignore_opacity = true,
            contrast = 1.5,
            xray = false,
            new_optimizations = true,
        },
    },
})

-- Default curves and animations
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
-- hl.curve("myBezier",   { type = "bezier", points = { {0.22, 1},  {0.36, 1}    } })
-- hl.curve("overshoot",  { type = "bezier", points = { {0.05, 0.9},{0.1, 1.0.5} } })

hl.animation({ leaf = "windowsIn",           enabled = true, speed = 7,  bezier = "myBezier", style = "popin" })
hl.animation({ leaf = "windowsOut",          enabled = true, speed = 7,  bezier = "myBezier", style = "popin 100%" })
hl.animation({ leaf = "windowsMove",         enabled = true, speed = 7,  bezier = "myBezier", style = "popin 100%" })
hl.animation({ leaf = "layersIn",            enabled = true, speed = 5,  bezier = "myBezier", style = "popin" })
hl.animation({ leaf = "layersOut",           enabled = true, speed = 5,  bezier = "myBezier", style = "popin 100%" })
hl.animation({ leaf = "fade",                enabled = true, speed = 9,  bezier = "myBezier" })
hl.animation({ leaf = "specialWorkspaceIn",  enabled = true, speed = 10, bezier = "myBezier", style = "fade" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 10, bezier = "myBezier", style = "fade" })
hl.animation({ leaf = "border",              enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "borderangle",         enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "workspaces",          enabled = true, speed = 5,  bezier = "myBezier", style = "slidevert" })

hl.config({
    dwindle = {
        -- See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
        -- pseudotile = true, -- master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true, -- you probably want this
        force_split = 2,
    },
})

hl.config({
    misc = {
        -- See https://wiki.hypr.land/Configuring/Variables/ for more
        force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true,
    },
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

hl.config({
    binds = {
        allow_workspace_cycles = true,
    },
})

-- Window Bindings 
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({ match = { class = ".*" }, focus_on_activate = true })

-- Ueberzugpp
-- hl.window_rule({ match = { class = ".*ueberzugpp.*" }, animation = "slide left" })

-- Blurring
hl.window_rule({ match = { title = "^(.*Telegram.*)$" }, no_blur = true })
-- hl.window_rule({ match = { class = "^(org.telegram.*)", title = "^(Media viewer)$" }, animation = "popin 100%" })
-- hl.layer_rule({ match = { class = "^(org.telegram.*)", title = "^(Media viewer)$" }, layer = true })

hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk)$" }, no_blur = true })
hl.window_rule({ match = { class = "^(Xdg-desktop-portal-gtk)$" }, no_blur = true })

-- hl.window_rule({ match = { class = "^(swayimg.*)$" }, blur = 0.5 })
-- hl.window_rule({ match = { class = "^(swayimg.*)$" }, opacity = "0.7 0.7" })
-- hl.window_rule({ match = { class = "^(swayimg.*)$" }, blur = true })
-- hl.window_rule({ match = { class = "^(swayimg.*)$" }, animation = "slide" })
-- hl.window_rule({ match = { class = "^(swayimg_.*)$" }, opacity = "0.8 0.8" })

hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk)$" }, float = true })
hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk)$" }, size = {1000, 600} })
hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk)$" }, center = true })

-- hl.layer_rule({ match = { namespace = "selection" }, no_anim = true })

hl.window_rule({ match = { class = "^(kitty)$" }, workspace = "1" })
hl.window_rule({ match = { class = "^(zen)$" }, workspace = "2" })
hl.window_rule({ match = { title = "^(.*Telegram.*)$" }, workspace = "3" })
hl.window_rule({ match = { class = "^(.*org.telegram.desktop.*)$" }, workspace = "3" })
hl.window_rule({ match = { class = "^(weechat)$" }, workspace = "4" })
hl.window_rule({ match = { class = "^(Pinterest)$" }, workspace = "5" })
hl.window_rule({ match = { class = "^(WhatsApp Desktop)$" }, workspace = "7" })
hl.window_rule({ match = { class = "^(syncplay)$" }, workspace = "8" })
hl.window_rule({ match = { title = "^(feed_mpv)$" }, workspace = "8" })
hl.window_rule({ match = { class = "^(Mailspring)$" }, workspace = "9" })
hl.window_rule({ match = { class = "^(discord)$" }, workspace = "10" })

hl.window_rule({ match = { class = "^(org.quickshell)$" }, float = true })
hl.window_rule({ match = { class = "^(org.quickshell)$", title = "^(Settings)$" }, size = {1000, 800} })


-- Key Bindings 
local mainMod = "SUPER"

hl.dsp.focus({ workspace = "previous" })
-- hl.bind("SUPER+Tab", hl.dsp.workspace.change({ workspace = "previous" }))
hl.bind("SUPER+Q", hl.dsp.window.close()) -- TODO: verify killactive maps to window.kill()
hl.bind("SUPER+SHIFT+Q", hl.dsp.window.kill()) -- TODO: verify killactive maps to window.kill()
hl.bind("SUPER+SHIFT+E", hl.dsp.exec_cmd(HOME .. "/.config/rofi/scripts/powermenu/powermenu"))
hl.bind("SUPER+F", hl.dsp.window.fullscreen()) -- TODO: verify fullscreen() args
hl.bind("SUPER+V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER+SHIFT+space", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER+C", hl.dsp.exec_cmd("makoctl dismiss --all"))
hl.bind("SUPER+W", hl.dsp.exec_cmd("dms restart"))
hl.bind("SUPER+SHIFT+C", hl.dsp.exec_cmd(HOME .. "/.config/waybar/scripts/dnd-toggle.sh toggle"))
-- hl.bind("SUPER+P", hl.dsp.layout.pseudo()) -- TODO: verify dwindle "pseudo" dispatcher name
-- hl.bind("SUPER+S", hl.dsp.layout.toggle_split()) -- dwindle togglesplit

-- Binding for Applications
hl.bind("SUPER + Return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER+B", hl.dsp.exec_cmd("zen-browser"))
hl.bind("SUPER+D", hl.dsp.exec_cmd(menu .. " -show drun"))
hl.bind("SUPER+E", hl.dsp.exec_cmd(menu .. " -modi emoji -show emoji"))
hl.bind("SUPER+SHIFT+F", hl.dsp.exec_cmd(menu .. " -modi filebrowser -show filebrowser"))
hl.bind("SUPER+T", hl.dsp.exec_cmd("XDG_DESKTOP_PORTAL=gtk " .. HOME .. "/Downloads/Telegram/Telegram"))
hl.bind("SUPER+O", hl.dsp.exec_cmd("/opt/WhatsApp\\ Desktop/whatsapp-linux-desktop"))
hl.bind("SUPER+N", hl.dsp.exec_cmd(HOME .. "/.bin/nightlight.sh"))
hl.bind("SUPER+SHIFT+B", hl.dsp.exec_cmd(HOME .. "/.bin/bookmarks.sh"))
hl.bind("SUPER+SHIFT+X", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER+X", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"))

-- Screenshot
hl.bind("SUPER+Y", hl.dsp.exec_cmd(HOME .. "/.config/rofi/scripts/screenshot/screenshot --clipboard-only"))
hl.bind("SUPER+SHIFT+Y", hl.dsp.exec_cmd(HOME .. "/.config/rofi/scripts/screenshot/screenshot"))
hl.bind("SUPER+Z", hl.dsp.exec_cmd([[grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" - | wl-copy]]))

-- Color picker
hl.bind("SUPER+SHIFT+P", hl.dsp.exec_cmd("hyprpicker -a"))

-- Move focus with mainMod + arrow keys
hl.bind("SUPER+h", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER+l", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER+k", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER+j", hl.dsp.focus({ direction = "down" }))

-- Move Windows
hl.bind("SUPER+SHIFT+h", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER+SHIFT+l", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER+SHIFT+k", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER+SHIFT+j", hl.dsp.window.move({ direction = "down" }))

-- Move Windows (Scrolling Layout) -- TODO: verify layout-message dispatcher name/shape
hl.bind("SUPER+period", hl.dsp.layout("colresize +0.1"))
hl.bind("SUPER+comma", hl.dsp.layout("colresize -0.1"))
hl.bind("SUPER+SHIFT+period", hl.dsp.layout("swapcol r"))
hl.bind("SUPER+SHIFT+comma", hl.dsp.layout("swapcol l"))

-- Resize Mode (Inspired by i3)
hl.bind("SUPER+R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("h", hl.dsp.window.resize({ x = -20, y = 0, relative = true }))
    hl.bind("l", hl.dsp.window.resize({ x = 20, y = 0, relative = true }))
    hl.bind("k", hl.dsp.window.resize({ x = 0, y = -20, relative = true }))
    hl.bind("j", hl.dsp.window.resize({ x = 0, y = 20, relative = true }))
    hl.bind("Escape", hl.dsp.submap("reset"))
end)

-- Switch workspaces / move window to workspace with mainMod + [0-9]
for i = 1, 10 do
    local key = i % 10

    hl.bind(mainMod .. " + " .. key, function()
        local active = hl.get_active_workspace()
        if active.id == i then
            hl.dispatch(hl.dsp.focus({ workspace = "previous" }))
        else
            hl.dispatch(hl.dsp.focus({ workspace = i }))
        end
    end)

    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
-- hl.bind("SUPER+S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind("SUPER+SHIFT+S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind("SUPER+0xffad", hl.dsp.workspace.toggle_special("magic"), { repeating = true })
hl.bind("SUPER+SHIFT+0xffad", hl.dsp.window.move({ workspace = "special:magic" }), { repeating = true })

-- Move workspaces with mainMod + Ctrl + up/down
hl.bind("CTRL+SUPER+up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("CTRL+SUPER+down", hl.dsp.focus({ workspace = "e+1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging -- TODO: verify mouse-bind dispatcher shape
-- hl.bind("SUPER+mouse:272", hl.dsp.window.move(), { mouse = true })
-- hl.bind("SUPER+mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume Controls
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(
    volume .. [[ +3% && notify-send --hint=string:x-dunst-stack-tag:wallpaper --hint=string:synchronous:wallpaper -c system-notification -t 450 --icon=]] .. iconpath ..
    [[/volume-plus.png "" --hint="int:value:$(]] .. HOME .. [[/.bin/volume.sh output %v)"]]
), { repeating = true })

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(
    volume .. [[ -3% && notify-send --hint=string:x-dunst-stack-tag:wallpaper --hint=string:synchronous:wallpaper -c system-notification -t 450 --icon=]] .. iconpath ..
    [[/volume-minus.png "" --hint="int:value:$(]] .. HOME .. [[/.bin/volume.sh output %v)"]]
), { repeating = true })

-- Mute toggles
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle && exec " .. HOME .. "/.bin/volmutetoggle.sh"), { repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle && exec " .. HOME .. "/.bin/mictoggle.sh"), { repeating = true })
hl.bind(mainMod .. "+M", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle && exec " .. HOME .. "/.bin/mictoggle.sh"))

-- Brightness Controls
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(
    brightness .. [[ s +2% && notify-send --hint=string:x-dunst-stack-tag:wallpaper --hint=string:synchronous:wallpaper -c system-notification -t 450 --icon=]] .. iconpath ..
    [[/brightness-up.png "" --hint="int:value:$(]] .. HOME .. [[/.bin/brightness_bar.sh)"]]
), { repeating = true })

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(
    brightness .. [[ s 2%- && notify-send --hint=string:x-dunst-stack-tag:wallpaper --hint=string:synchronous:wallpaper -c system-notification -t 450 --icon=]] .. iconpath ..
    [[/brightness-down.png "" --hint="int:value:$(]] .. HOME .. [[/.bin/brightness_bar.sh)"]]
), { repeating = true })

-- DMS
hl.bind("SUPER+SHIFT+D", hl.dsp.exec_cmd("dms ipc call settings toggle"))
