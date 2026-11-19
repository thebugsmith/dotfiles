-- Window and layer rules configuration
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Opacity rules (no opacity)
local noOpacityApps = {
    "com.obsproject.Studio",
    "com.stremio.stremio",
    "libreoffice-writer",
    "VencordDesktop",
    "steam",
    "feh",
    "Gimp-2.10",
    "mpv",
    "scrcpy",
    "firefox",
    "chromium-browser",
    "[Cc]ode",
}

for _, app in ipairs(noOpacityApps) do
    hl.window_rule({
        name  = "no-opacity-" .. app,
        match = { class = "^(" .. app .. ")$" },
        opacity = 1.0,
    })
end

-- Opacity rules (semi-transparent)
hl.window_rule({
    name  = "opacity-arduino",
    match = { class = "^(Arduino IDE)$" },
    opacity = 0.85,
})

hl.window_rule({
    name  = "opacity-obsidian",
    match = { class = "^(obsidian)$" },
    opacity = 0.95,
})

hl.window_rule({
    name  = "opacity-kitty",
    match = { class = "^(kitty)$" },
    opacity = 0.85,
})

hl.window_rule({
    name  = "opacity-nautilus",
    match = { class = "^(org.gnome.Nautilus)$" },
    opacity = 0.85,
})

hl.window_rule({
    name  = "opacity-spotify",
    match = { class = "^(Spotify)$" },
    opacity = 0.75,
})

hl.window_rule({
    name  = "opacity-telegram",
    match = { class = "^(org.telegram.desktop)$" },
    opacity = 1,
})

hl.window_rule({
    name  = "opacity-copyq",
    match = { class = "^(com.github.hluk.copyq)$" },
    opacity = 0.85,
})

-- Floating window rules
hl.window_rule({
    name  = "float-spotify",
    match = { class = "^(Spotify)$" },
    float = true,
})

hl.window_rule({
    name  = "float-telegram",
    match = { class = "^(org.telegram.desktop)$" },
    float = true,
})

hl.window_rule({
    name  = "float-tor-browser",
    match = { class = "^(Tor Browser)$" },
    float = true,
})

hl.window_rule({
    name  = "float-copyq",
    match = { class = "^(com.github.hluk.copyq)$" },
    float = true,
})

hl.window_rule({
    name  = "float-wallpaper-picker",
    match = { class = "^(org.quickshell)$", title = "^(WallpaperPicker)$" },
    float = true,
    border_size = 0,
    border_color = "rgba(00000000)",
})

hl.window_rule({
    name  = "float-transmission",
    match = { class = "^(com.transmissionbt.transmission*)$" },
    float = true,
})

hl.window_rule({
    name  = "float-calculator",
    match = { class = "^(org.gnome.Calculator)$" },
    float = true,
})

-- Float system dialogs
local dialogTitles = {
    "branchdialog",
    "Open File",
    "^(Open)$",
    "^(Choose Files)$",
    "^(Save As)$",
    "^(Confirm to replace files)$",
    "^(File Operation Progress)$",
}

for _, title in ipairs(dialogTitles) do
    hl.window_rule({
        name  = "float-dialog-" .. title,
        match = { title = title },
        float = true,
    })
end

-- Workspace rules for special workspaces
hl.workspace_rule({
    workspace = "special:Obsidian",
    layout    = "dwindle",
})

hl.workspace_rule({
    workspace = "special:terminal",
    layout    = "dwindle",
})

hl.workspace_rule({
    workspace = "special:Calculator",
    layout    = "dwindle",
})

hl.workspace_rule({
    workspace = "special:FileManager",
    layout    = "dwindle",
})

hl.workspace_rule({
    workspace = "special:Spotify",
    layout    = "dwindle",
})
