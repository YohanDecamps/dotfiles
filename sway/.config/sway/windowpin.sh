#!/bin/sh
# Toggle a "grabbed" window: float + stick it, and re-tile when released.
# Port of the Hyprland windowpin.sh (super+shift+f); sway's native `sticky`
# only sticks floating windows, so a tiled window must be floated first.
q() { swaymsg -t get_tree | jq -r "first(.. | objects | select(.focused? == true and (.app_id? or .window_properties?))) | .$1"; }
isfloat() { case "$1" in user_on|auto_on) return 0 ;; *) return 1 ;; esac; }

f=$(q floating)
s=$(q sticky)
if ! isfloat "$f" && [ "$s" = false ]; then swaymsg floating enable >/dev/null; fi
swaymsg sticky toggle >/dev/null
f=$(q floating)
s=$(q sticky)
if isfloat "$f" && [ "$s" = false ]; then swaymsg floating disable >/dev/null; fi
