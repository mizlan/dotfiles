#!/bin/sh

# close prefs first
osascript -e 'tell application "System Preferences" to quit'

# set hostname
sudo scutil --set HostName 'virgil'

# Finder: add option to quit
defaults write com.apple.finder "QuitMenuItem" -bool "true"

# Finder: show all extensions
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# Finder: show path at bottom
defaults write com.apple.finder "ShowPathbar" -bool "true"

# Finder: prefer column view
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"

# Finder: don't prompt to save to iCloud
defaults write NSGlobalDomain "NSDocumentSaveNewDocumentsToCloud" -bool "false"

# Menubar clock format
defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE d h:mm\""

# Do not touch my spaces!
defaults write com.apple.dock "mru-spaces" -bool "false" && killall Dock

# Dock: don't show recent
defaults write com.apple.dock show-recents -bool false

# Disable automatic emoji substitution
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

killall Dock
killall Finder
