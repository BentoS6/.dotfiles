#!/usr/bin/env bash

# Get current input method name from fcitx5
im="$(fcitx5-remote -n 2>/dev/null)"

case "$im" in
    keyboard-us)
        echo "EN"
        ;;
    mozc*|pinyin*|rime*)
        echo "JP"   # or CN / whatever you want
        ;;
    *)
        # Fallback: show raw name if we don't know it
        echo "${im:---}"
        ;;
esac
