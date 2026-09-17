#!/usr/bin/env bash
# ~/.config/hypr/scripts/brightness_notify.sh
# Usage: brightness_notify.sh 10%+ | 10%-
# Adjusts backlight via brightnessctl and shows a dunst notification.

set -uo pipefail

STACK_TAG="brightness"
MIN="5%"   # floor, so you can't blank the panel with one keypress

get_brightness() {
    # -m output: device,class,current,percent,max  ->  field 4 is "42%"
    brightnessctl -m | cut -d, -f4 | tr -d '%'
}

notify() {
    local val="$1" icon

    if [[ "$val" -lt 34 ]]; then
        icon="display-brightness-low"
    elif [[ "$val" -lt 67 ]]; then
        icon="display-brightness-medium"
    else
        icon="display-brightness-high"
    fi

    notify-send \
        -a "brightness" \
        -u low \
        -t 1500 \
        -i "$icon" \
        -h "string:x-dunst-stack-tag:${STACK_TAG}" \
        -h "int:value:${val}" \
        "Brightness  ${val}%"
}

case "${1:-}" in
    *%+)
        brightnessctl -q set "$1"
        ;;
    *%-)
        brightnessctl -q set "$1" -n "$MIN"
        ;;
    *)
        echo "usage: ${0##*/} 10%+ | 10%-" >&2
        exit 1
        ;;
esac

notify "$(get_brightness)"
