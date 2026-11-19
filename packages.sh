#!/usr/bin/env bash
# Packages required by the Hyprland setup in this repo
# (.config/hypr, waybar, dunst, kitty, kanata, mpv, quickshell, copyq, .zshrc).
set -euo pipefail

# Everything here comes from the official Arch repos.
REPO_PKGS=(
    # compositor + session
    hyprland
    xdg-desktop-portal-hyprland
    hyprlauncher          # ALT+space launcher
    polkit-gnome          # autostart: polkit-gnome-authentication-agent-1

    # bar, notifications, OSD, wallpaper, eye care
    waybar
    dunst                 # also provides dunstify, used by dunst/bin/*.sh
    swayosd               # autostart: swayosd-server
    awww                  # autostart: awww-daemon

    # terminal, launcher, clipboard, widgets
    kitty
    wofi                  # wofi-emoji picker (ALT+X)
    wl-clipboard          # wl-copy, used by wofi-emoji
    copyq
    quickshell            # qs -c wallpaperPicker (ALT+L)

    # screenshots
    hyprshot              # SUPER+PRINT, CTRL+mouse:275
    slurp                 # region selection for PRINT/wayshot

    # desktop apps bound in keybinds.lua
    nautilus
    gnome-calculator
    firefox
    mpv

    # audio, media, brightness
    pipewire
    pipewire-pulse
    wireplumber           # wpctl
    pavucontrol
    libpulse              # paplay, used by dunst/alert.sh
    playerctl
    easyeffects           # CTRL+ALT+E / CTRL+ALT+D presets
    brightnessctl

    # gtk/qt theming (environment.lua, theme.lua)
    glib2                 # gsettings
    kvantum
    qt6ct

    # shell helpers (.zshrc aliases, dunst scripts)
    zsh
    eza
    fzf
    pyenv
    libnotify             # notify-send
    imagemagick           # magick, used by cache_wallpaper.sh

    # fonts referenced by theme.lua and the waybar icon config
    ttf-nerd-fonts-symbols
    cantarell-fonts
)

# Not in the official repos; needs an AUR helper.
AUR_PKGS=(
    kanata                # systemd --user kanata.service
    wayshot               # AUR build (repo name matches, binary is AUR-only)
    safeeyes              # autostart: /usr/bin/safeeyes
)

SUDO=""
[[ $EUID -ne 0 ]] && SUDO="sudo"

echo "==> Installing official repo packages"
$SUDO pacman -S --needed --noconfirm "${REPO_PKGS[@]}"

missing_aur=()
for pkg in "${AUR_PKGS[@]}"; do
    pacman -Qq "$pkg" >/dev/null 2>&1 || missing_aur+=("$pkg")
done

if (( ${#missing_aur[@]} == 0 )); then
    echo "==> AUR packages already installed"
    exit 0
fi

helper=""
for h in paru yay; do
    if command -v "$h" >/dev/null 2>&1; then helper="$h"; break; fi
done

if [[ -n $helper ]]; then
    echo "==> Installing AUR packages: ${missing_aur[*]}"
    "$helper" -S --needed --noconfirm "${missing_aur[@]}"
else
    echo "!! No AUR helper (paru/yay) found. Install these manually:" >&2
    printf '   %s\n' "${missing_aur[@]}" >&2
    exit 1
fi
