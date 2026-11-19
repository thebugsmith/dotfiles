-- Keybindings configuration
-- See https://wiki.hypr.land/Configuring/Basics/Binds/

-- Define program variables
local terminal    = "kitty"
local fileManager = "nautilus --new-window"
local launcher    = "hyprlauncher"
local binPath     = os.getenv("HOME") .. "/.apps/bin"
local mainMod     = "SUPER"

--==================--
-- APPLICATION LAUNCHERS
--==================--

-- Primary applications
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind("ALT + space", hl.dsp.exec_cmd(launcher))

-- Utilities
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("gnome-calculator"))
hl.bind("ALT + X", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.apps/bin/wofi-emoji"))

-- Firefox sites
hl.bind("CTRL + ALT + Y", hl.dsp.exec_cmd("firefox -P jag -new-window https://youtube.com/"))
hl.bind("CTRL + ALT + S", hl.dsp.exec_cmd("firefox -P jag -new-window https://open.spotify.com/"))
hl.bind("CTRL + ALT + G", hl.dsp.exec_cmd("firefox -P default-release -new-window https://mail.google.com/mail/u/0/"))

-- Firefox profiles
hl.bind(mainMod .. " + ALT + M", hl.dsp.exec_cmd("firefox -P default-release"))
hl.bind(mainMod .. " + ALT + N", hl.dsp.exec_cmd("firefox -P std"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox -P jag"))

-- Wallpaper
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(binPath .. "/random_wall.sh"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("kitty /usr/bin/python3 /home/darthvader/.local/bin/waypaper"))
hl.bind("ALT + L", hl.dsp.exec_cmd("qs -c wallpaperPicker"))

-- Clipboard manager
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("copyq toggle"))

-- Screenshots
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
-- hl.bind("PRINT", hl.dsp.exec_cmd("wayshot -g"))
hl.bind("PRINT", hl.dsp.exec_cmd('wayshot FILE -g "$(slurp)" --clipboard'))
-- hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind("CTRL + mouse:275", hl.dsp.exec_cmd("hyprshot -m region"))

-- Sidebar toggle
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("ags --toggle-window sidebar"))

--==================--
-- WINDOW MANAGEMENT
--==================--

-- Window actions
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind("CONTROL + SHIFT + escape", hl.dsp.exit())
hl.bind(mainMod .. " + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Focus movement (Vim-style)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move window position
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Window resizing
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 100, y = 0 }), { description = "Increase window width with keyboard" })
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.resize({ x = -40, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.resize({ x = 40, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -40 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 40 }), { repeating = true })

-- Mouse window actions
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize submap
hl.bind("ALT + R", function()
    hl.submap("resize")
end)

local resizeMapActive = false
function setupResizeMap()
    if resizeMapActive then return end
    resizeMapActive = true
    
    hl.bind("+ right", hl.dsp.window.resize({ direction = "right", amount = 10 }), { repeating = true })
    hl.bind("+ left", hl.dsp.window.resize({ direction = "left", amount = 10 }), { repeating = true })
    hl.bind("+ up", hl.dsp.window.resize({ direction = "up", amount = 10 }), { repeating = true })
    hl.bind("+ down", hl.dsp.window.resize({ direction = "down", amount = 10 }), { repeating = true })
    hl.bind("+ escape", function() 
        resizeMapActive = false
        hl.submap("reset")
    end)
end

--==================--
-- WORKSPACE MANAGEMENT
--==================--

-- Switch to workspaces (1-10)
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
end

-- Additional workspace navigation
hl.bind(mainMod .. " + ALT + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + ALT + left", hl.dsp.focus({ workspace = "e-1" }))

-- Move windows to workspaces
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Workspace cycling
hl.bind("SUPER + TAB", hl.dsp.focus({ workspace = "previous" }))

-- Mouse workspace switching
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Quick workspace change
hl.bind("+ KP_Enter", hl.dsp.focus({ workspace = 3 }))

-- Special workspaces (scratchpad)
hl.bind("ALT + O", hl.dsp.workspace.toggle_special("Obsidian"))
hl.bind("ALT + Z", hl.dsp.workspace.toggle_special("terminal"))
hl.bind("ALT + C", hl.dsp.workspace.toggle_special("Calculator"))
hl.bind("ALT + F", hl.dsp.workspace.toggle_special("FileManager"))
hl.bind("ALT + S", hl.dsp.workspace.toggle_special("Spotify"))

-- Move windows to special workspaces
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.window.move({ workspace = "special:Obsidian" }))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "special:terminal" }))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.move({ workspace = "special:Calculator" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.move({ workspace = "special:FileManager" }))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:Spotify" }))

--==================--
-- MEDIA & SYSTEM CONTROLS
--==================--

-- Volume controls
hl.bind("+ XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("+ XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("+ XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("+ XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle"), { locked = true })

-- Media player controls
hl.bind("+ XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { repeating = true })
hl.bind("+ XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { repeating = true })
hl.bind("+ XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

hl.bind("CONTROL + ALT + comma", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("CONTROL + ALT + period", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("CONTROL + ALT + space", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

-- Brightness controls
hl.bind("+ XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { repeating = true })
hl.bind("+ XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { repeating = true })

-- System controls
hl.bind("CONTROL + ALT + W", hl.dsp.exec_cmd("pkill waybar || waybar"))
hl.bind("CONTROL + ALT + A", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.apps/bin/date_dunst.sh"))

-- Power management (suspend on lid switch)
hl.bind("+ switch:on:Lid Switch", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })

-- Easy effect toggling
-- to turn on easyeffects -l "laptop right"
-- to turn off easyeffects -l "clean sound"
hl.bind("CONTROL + ALT + E", hl.dsp.exec_cmd("easyeffects -l \"laptop right\""), { locked = true })
hl.bind("CONTROL + ALT + D", hl.dsp.exec_cmd("easyeffects -l \"clean sound\""), { locked = true })