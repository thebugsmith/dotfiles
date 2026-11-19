-- Hyprland Lua Configuration
-- This is the main entry point for the Hyprland Lua configuration
-- All other configuration modules are required below

-- Basic program definitions at the top level
local terminal    = "kitty"
local fileManager  = "nautilus"
local menu        = "hyprlauncher"

-- Load all configuration modules
require("monitors")
require("input")
require("environment")
require("appearance")
require("animations")
require("theme")
require("autostart")
require("window-rules")
require("keybinds")

-- Optional: Enable debug logging
-- hl.debug(true)
