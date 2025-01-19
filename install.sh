#!/bin/sh

# A: pre-existing configuration files on machine B: dotfiles within git
# repository
#
# To force the dotfiles within the git repository to match the pre-existing
# configuration files on the machine, use --adopt. This updates the files
# within the git repository and regenerates symlinks on the machine to point to
# said files.
#
# If alternatively you would like the machine's symlinks to reflect the state
# of the git repository, first commit the current state of the repository, then
# run stow --adopt like above, then run
#
#   git reset --hard
#
# which discards any new changes.
#
# ref: https://unix.stackexchange.com/a/698982
#
# The option --no-folding means to only symlink the "leaves", a.k.a. the files
# and not the directories. This in effect prevents automatic tracking of newly
# created files, since a newly created file on the machine won't be a symlink
# pointing into the git repository. You may use --adopt to update the git
# repository. Conversely, using --folding, new files will be tracked since the
# file will be created within the git repository (since some parent directory
# itself *is a symlink* to the some directory within the repository)
#
# Using --target="$HOME" guarantees that the path inside each top-level
# directory of the git repository will be constructed relative to the home
# directory. By default it is constructed relative to the parent directory.
# Omitting this will cause problems, for instance, if the git repository is in
# ~/Repo/dotfiles and stowing ~/Repo/dotfiles/nvim/.config/nvim/.. will end up
# with a directory ~/Repo/.config/nvim/..

stow --no-folding --target="$HOME" zsh
stow --no-folding --target="$HOME" kitty
stow --no-folding --target="$HOME" nvim
stow --no-folding --target="$HOME" scripts
stow --no-folding --target="$HOME" wallpapers
stow --no-folding --target="$HOME" sketchybar
stow              --target="$HOME" yabai
stow              --target="$HOME" skhd
stow              --target="$HOME" borders
# atuin autogenerates its config, so we need to remove the old one first
rm -rf ~/.config/atuin && stow --target="$HOME" atuin
