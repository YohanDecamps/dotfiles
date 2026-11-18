#!/bin/sh
# Switch to the numbered workspace one step left/right, creating it if needed.
# Sway has no relative-workspace command, so compute the target number here.
# Usage: workspace-relative.sh prev|next
cur=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused) | .num')
[ "$cur" -ge 1 ] 2>/dev/null || cur=1
case "$1" in
    next) n=$(( cur % 10 + 1 )) ;;          # 1..10, wraps 10 -> 1
    prev) n=$(( (cur + 8) % 10 + 1 )) ;;    # 1..10, wraps 1 -> 10
    *) echo "usage: $0 prev|next" >&2; exit 2 ;;
esac
swaymsg workspace number "$n"
