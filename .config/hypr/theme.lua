-- Theme and appearance configuration
-- GTK, fonts, and visual settings

-- GTK and icon themes
hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'Catppuccin-Frappe'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")

-- Cursor theme and settings
hl.exec_cmd("hyprctl setcursor 'Bibata-Modern-Ice' 20")
hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Jaroo'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 20")

-- Font configuration
hl.exec_cmd("gsettings set org.gnome.desktop.interface font-name 'Cantarell 12'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface document-font-name 'Cantarell 12'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface monospace-font-name 'CaskaydiaCove Nerd Font Mono 11'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface font-hinting 'full'")
