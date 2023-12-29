#!/bin/sh

# A: pre-existing configuration files on machine
# B: dotfiles within git repository
#
# use --adopt when stowing to replace B with A
# and create symlinks to the new files.
#
# since these are symlinks, if you would've instead
# liked to replace A with B, then run
#
#   git reset --hard
#
# which discards all the new changes, assuming
# the repository state was clean to begin with
#
# ref: https://unix.stackexchange.com/a/698982

stow --no-folding --target="$HOME" zsh
stow --no-folding --target="$HOME" kitty
stow --no-folding --target="$HOME" nvim
stow --no-folding --target="$HOME" scripts
stow --no-folding --target="$HOME" wallpapers
stow --no-folding --target="$HOME" sketchybar
stow              --target="$HOME" theming
stow              --target="$HOME" yabai
stow              --target="$HOME" skhd
