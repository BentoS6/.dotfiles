#!/usr/bin/env bash
# ~/.config/hypr/scripts/volume_notify.sh
# Usage: volume_notify.sh 5%+ | 5%- | toggle
# Adjusts the default sink and shows a dunst notification with a progress bar.

set -uo pipefail

SINK="@DEFAULT_SINK@"
STACK_TAG="volume"   # dunst replaces the previous notification with this tag
MAX=100              # don't let volume boost past 100%

get_volume() {
    pactl get-sink-volume "$SINK" | grep -oP '\d+(?=%)' | head -1
}

is_muted() {
    [[ "$(pactl get-sink-mute "$SINK" | awk '{print $2}')" == "yes" ]]
}

notify() {
    local vol="$1" icon summary

    if is_muted || [[ "$vol" -eq 0 ]]; then
        icon="audio-volume-muted"
        summary="Muted"
        vol=0
    elif [[ "$vol" -lt 34 ]]; then
        icon="audio-volume-low"
        summary="Volume  ${vol}%"
    elif [[ "$vol" -lt 67 ]]; then
        icon="audio-volume-medium"
        summary="Volume  ${vol}%"
    else
        icon="audio-volume-high"
        summary="Volume  ${vol}%"
    fi

    notify-send \
        -a "volume" \
        -u low \
        -t 1500 \
        -i "$icon" \
        -h "string:x-dunst-stack-tag:${STACK_TAG}" \
        -h "int:value:${vol}" \
        "$summary"
}

case "${1:-}" in
    *%+)
        pactl set-sink-mute "$SINK" 0
        pactl set-sink-volume "$SINK" "+${1%+}"
        # clamp: pactl happily goes past 100%
        [[ "$(get_volume)" -gt "$MAX" ]] && pactl set-sink-volume "$SINK" "${MAX}%"
        ;;
    *%-)
        pactl set-sink-volume "$SINK" "-${1%-}"
        ;;
    toggle|mute)
        pactl set-sink-mute "$SINK" toggle
        ;;
    *)
        echo "usage: ${0##*/} 5%+ | 5%- | toggle" >&2
        exit 1
        ;;
esac

notify "$(get_volume)"
