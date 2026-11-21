#!/usr/bin/env python3
"""Rofi with menu.png behind it and mask.png on top, synchronously.

Usage: mask-overlay.py [args for rofi]

No daemon, no preload, nothing kept between launches. Everything
happens in this one process, in order:
  1. Load menu.png and mask.png and scale both (blocking).
  2. Show menu.png as the background and only then launch Rofi.
  3. Show mask.png on top of Rofi; quit when Rofi exits.

menu.png is NOT Rofi's background-image: Rofi loads theme images
asynchronously, so its window appears first and the background pops
in later. Drawing menu.png here -- already decoded before Rofi
even starts -- makes it visible the moment Rofi opens. Rofi's own
window is therefore transparent (see config.rasi) and sits between
the two overlay windows.

Stacking is by layer-shell layer, not by timing:
  1. menu.png  -- this process, layer TOP, shown before Rofi
  2. Rofi UI   -- Rofi, launched with -wayland-layer top, so it
                  stacks above menu.png (same layer, created later)
  3. mask.png  -- this process, layer OVERLAY, above Rofi
                  (OVERLAY > TOP) no matter when it mapped
  Because both overlays are mapped before Rofi is launched, both
  are present in Rofi's very first frame -- no pop-in, and the
  mask is in front from the start.

Same scale for both images: both are scaled by W / menu_nat_w
(scaling mask.png to width W instead would make it ~5% larger).
Both alpha bounding boxes are 483x778 px but at different canvas
offsets (menu 58,74; mask 44,70), so the mask canvas is shifted
(+14,+4) natural px to align the silhouettes edge-to-edge.
"""
import subprocess
import sys

import gi
gi.require_version('Gtk', '3.0')
gi.require_version('GtkLayerShell', '0.1')
from gi.repository import Gtk, Gdk, GdkPixbuf, GtkLayerShell, GLib

ROFI_DIR = "/home/gaia/.config/rofi"
MASK = f"{ROFI_DIR}/mask.png"
MENU = f"{ROFI_DIR}/menu.png"
# Must match `window { width/height }` in config.rasi (centred there,
# and centred the same way below).
W, H = 783, 1200
MASK_DX, MASK_DY = 14, 4  # canvas offset aligning mask to menu (above)

# --- 1. load both images, scale both with menu's scale -----------------
menu_nat = GdkPixbuf.Pixbuf.new_from_file(MENU)
scale = W / menu_nat.get_width()
menu_pixbuf = menu_nat.scale_simple(
    W, round(menu_nat.get_height() * scale),
    GdkPixbuf.InterpType.BILINEAR)
mask_nat = GdkPixbuf.Pixbuf.new_from_file(MASK)
mask_pixbuf = mask_nat.scale_simple(
    round(mask_nat.get_width() * scale),
    round(mask_nat.get_height() * scale),
    GdkPixbuf.InterpType.BILINEAR)
MASK_OFF_X = round(MASK_DX * scale)
MASK_OFF_Y = round(MASK_DY * scale)

def make_window(pixbuf, off_x, off_y, layer):
    def on_draw(widget, cr):
        alloc = widget.get_allocation()
        # Rofi's window is centred: centre the W x H box the same way.
        x = (alloc.width - W) // 2 + off_x
        y = (alloc.height - H) // 2 + off_y
        # Fresh surface every draw; a cached one goes stale when the
        # window is unrealized.
        surface = Gdk.cairo_surface_create_from_pixbuf(
            pixbuf, 1.0, widget.get_window())
        cr.set_source_surface(surface, x, y)
        cr.paint()
        return False

    win = Gtk.Window()
    GtkLayerShell.init_for_window(win)
    GtkLayerShell.set_layer(win, layer)
    GtkLayerShell.set_keyboard_mode(win, GtkLayerShell.KeyboardMode.NONE)
    for edge in (GtkLayerShell.Edge.LEFT, GtkLayerShell.Edge.RIGHT,
                 GtkLayerShell.Edge.TOP, GtkLayerShell.Edge.BOTTOM):
        GtkLayerShell.set_anchor(win, edge, True)
    visual = Gdk.Screen.get_default().get_rgba_visual()
    if visual:
        win.set_visual(visual)
    win.set_app_paintable(True)
    area = Gtk.DrawingArea()
    area.connect("draw", on_draw)
    win.add(area)
    return win

def pump_events():
    # Realize/map a just-shown window now, before the next window is
    # created, so layer stacking follows the intended order.
    ctx = GLib.MainContext.default()
    while ctx.pending():
        ctx.iteration(False)

# --- 2. both overlays on screen before Rofi exists ----------------------
# menu.png on TOP (below Rofi, also TOP but created later) and
# mask.png on OVERLAY (above Rofi by layer). Both are mapped
# before Rofi is launched, so both are present in its first frame.
menu_win = make_window(menu_pixbuf, 0, 0, GtkLayerShell.Layer.TOP)
menu_win.show_all()
pump_events()
mask_win = make_window(
    mask_pixbuf, MASK_OFF_X, MASK_OFF_Y, GtkLayerShell.Layer.OVERLAY)
mask_win.show_all()
pump_events()

# Rofi must be on TOP (not its default OVERLAY, which nothing can
# stack above deterministically); respect an explicit user choice.
rofi_args = list(sys.argv[1:])
if "-wayland-layer" not in rofi_args:
    rofi_args = ["-wayland-layer", "top", *rofi_args]
rofi = subprocess.Popen(["rofi", *rofi_args])

# --- 3. quit when Rofi exits ---------------------------------------------

def check_rofi():
    if rofi.poll() is not None:
        Gtk.main_quit()
        return False
    return True

GLib.timeout_add(100, check_rofi)
try:
    Gtk.main()
finally:
    if rofi.poll() is None:
        rofi.terminate()
sys.exit(rofi.wait())
