#!/bin/sh
# Toggle the scratchpad window, making it fill the screen when shown.
# Sway's scratchpad holds floating windows; a hidden one lives under the
# __i3_scratch workspace and is moved out when shown, so a drop in that count
# means we just revealed a window -> fullscreen it.
count_hidden() {
    swaymsg -t get_tree \
        | jq '[.. | objects | select(.type?=="workspace" and .name=="__i3_scratch") | .. | objects | select(.pid?)] | length'
}
before=$(count_hidden)
swaymsg scratchpad show >/dev/null
[ "$(count_hidden)" -lt "$before" ] && swaymsg fullscreen enable >/dev/null 2>&1
exit 0
