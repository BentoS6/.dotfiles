#!/bin/zsh

brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)
percent=$(( brightness * 100 / max_brightness ))

echo "{\"text\": \" ${percent}%\", \"tooltip\": \"Brightness: ${percent}%\"}"
