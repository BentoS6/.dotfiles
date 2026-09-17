#!/bin/bash
timestamp=$(date +%Y%m%d-%H%M%S)
filename="mpv-${timestamp}.png"
path="/home/keys/me_meow/anki/immersion_data/${filename}"
echo "$path" | wl-copy
echo "$filename"
