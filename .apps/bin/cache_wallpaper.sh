#!/usr/bin/env zsh

mkdir -p ~/.cache/wallpaper_picker/thumbs

# Added (N) to safely ignore missing extensions
for f in ~/Pictures/Wallpapers/dark/*.{jpg,jpeg,png,webp}(N); do
  [ -f "$f" ] || continue
  name=$(basename "$f")
  thumb="$HOME/.cache/wallpaper_picker/thumbs/$name"
  
  [ -f "$thumb" ] || magick "$f" -thumbnail 320x180^ -gravity center -extent 320x180 "$thumb"
done
