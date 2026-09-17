#!/bin/bash
# ~/.config/ranger/setwall.sh

cat > ~/.config/hypr/hyprpaper.conf <<EOF
wallpaper {
    monitor =
    path = $1
    fit_mode = cover
}
EOF

pkill hyprpaper
hyprpaper & disown