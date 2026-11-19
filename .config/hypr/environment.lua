-- Environment variables
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- Cursor settings
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Jaroo")
hl.env("HYPRCURSOR_SIZE", "24")

-- Wayland configuration
hl.env("EGL_PLATFORM", "wayland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- Firefox/Mozilla settings
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")

-- Qt configuration
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1.25")
hl.env("QT_STYLE_OVERRIDE", "kvantum")

-- NVIDIA-specific settings
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("__GL_VRR_ALLOWED", "1")
hl.env("WLR_DRM_NO_ATOMIC", "1")
hl.env("NVD_BACKEND", "direct")

-- Hardware cursor settings
hl.config({
    cursor = {
        no_hardware_cursors = true,
    },
})
