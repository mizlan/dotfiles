#!/bin/sh

# used with cormacrelf/dark-notify

theme="$1"

if [ "$theme" = "light" ]; then
  kitty @ set-colors --all "$HOME/.config/kitty/Ayu Light.conf"
else
  kitty @ set-colors --all "$HOME/.config/kitty/Ayu Mirage.conf"
fi
