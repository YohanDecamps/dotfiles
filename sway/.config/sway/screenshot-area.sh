#!/bin/sh
# Take an area-selection screenshot: drag to select, saves to
# ~/Pictures/Screenshots/, copies to the clipboard, and notifies.
# Pressing Esc (or a tiny/cancelled selection) aborts silently.
dir="$HOME/Pictures/Screenshots"
mkdir -p "$dir"
file="$dir/screenshot-$(date +%Y%m%d-%H%M%S).png"

region=$(slurp) || exit 0
[ -z "$region" ] && exit 0

grim -g "$region" "$file" || exit 0
wl-copy < "$file" 2>/dev/null &
notify-send -t 3000 "Screenshot saved" "$file (copied to clipboard)"
