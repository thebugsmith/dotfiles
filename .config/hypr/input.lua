-- Input configuration
-- See https://wiki.hypr.land/Configuring/Basics/Input/

hl.config({
    input = {
        kb_layout      = "us",
        kb_variant     = "",
        kb_model       = "",
        kb_options     = "grp:shifts_toggle",
        kb_rules       = "",
        follow_mouse   = 1,
        sensitivity    = 0.5,
        accel_profile  = "adaptive",
        
        touchpad = {
            natural_scroll = true,
            drag_lock      = 0,
        },
        
        numlock_by_default = false,
    },
})

-- Gestures
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace"
})
