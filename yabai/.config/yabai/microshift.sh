#!/bin/dash

# used to force windows to resize, to
# allow Neovide to redraw

v="$(yabai -m config bottom_padding)"
vnew="$(($v+10))"
yabai -m config bottom_padding "$vnew"
yabai -m config bottom_padding "$v"
