#!/usr/bin/env bash
DEVICE=$(upower -e | grep -i DisplayDevice || upower -e | grep -i battery | head -n1)
UPINFO=$(upower -i "$DEVICE")
PERCENT=$(printf "%s" "$UPINFO" | awk '/percentage/ {gsub("%",""); print int($2); exit}')
STATE=$(printf "%s" "$UPINFO" | awk -F': ' '/state/ {gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2; exit}')
ONLINE=$(printf "%s" "$UPINFO" | awk -F': ' '/online/ {gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2; exit}')

if [ "$PERCENT" -ge 90 ]; then ICON=""
elif [ "$PERCENT" -ge 70 ]; then ICON=""
elif [ "$PERCENT" -ge 50 ]; then ICON=""
elif [ "$PERCENT" -ge 20 ]; then ICON=""
else ICON=""
fi

if [ "$PERCENT" -eq 100 ] || [ "$STATE" = "fully-charged" ]; then TEXT="full:${PERCENT}%"
elif [ "$STATE" = "charging" ]; then TEXT="charging:${PERCENT}%"
elif [ "$ONLINE" = "yes" ]; then TEXT="plugged:${PERCENT}%"
else TEXT="battery:${PERCENT}%"
fi

if [ "$PERCENT" -ge 90 ]; then CLS="good"
elif [ "$PERCENT" -ge 20 ]; then CLS="warning"
else CLS="critical"
fi

echo "{\"text\": \"${ICON} ${TEXT}\", \"capacity\": ${PERCENT}, \"percentage\": ${PERCENT}, \"icon\": \"${ICON}\", \"state\": \"${STATE}\", \"class\": [\"${CLS}\"]}"
