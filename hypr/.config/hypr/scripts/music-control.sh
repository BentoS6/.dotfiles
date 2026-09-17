#!/bin/zsh

# script to manage music control
case "$1" in
    play) playerctl play ;;
    pause) playerctl pause ;;
    toggle) playerctl play-pause ;;
    next) playerctl next ;;
    prev) playerctl previous ;;
    *) echo "Usage: $0 {play|pause|toggle|next|prev}" ;;
esac
