-- Autostart programs
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Run on startup (executed once)
hl.on("hyprland.start", function()
    -- Authentication agent
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- Wallpaper daemon
    hl.exec_cmd("/usr/bin/awww-daemon")

    -- Eye care software
    hl.exec_cmd("/usr/bin/safeeyes")

    -- System OSD daemon
    hl.exec_cmd("swayosd-server")

    -- Clipboard history manager
    hl.exec_cmd("copyq")
end)
