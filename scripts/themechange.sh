#!/bin/sh

if [ $# -eq 0 ]; then
  if grep -q dark "$HOME/theme"; then
    theme=light
  else
    theme=dark
  fi
else
  theme="$1"
fi

if [ "$theme" = "light" ]; then
  kitty +kitten themes --reload-in=all --cache-age=-1 "Rosé Pine Dawn"
  kitty @ set-colors -a "$HOME/.config/kitty/dawn.conf"
  echo 'light' > "$HOME/theme"
else
  kitty +kitten themes --reload-in=all --cache-age=-1 "Rosé Pine Moon"
  kitty @ set-colors -a "$HOME/.config/kitty/moon.conf"
  echo 'dark' > "$HOME/theme"
fi
