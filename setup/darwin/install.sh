#!/bin/sh
"-> Installing xcode command line tools"
xcode-select --install

"-> Installing homebew"
/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

"-> Installing from homebrew"
brew bundle
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
defaults write NSGlobalDomain KeyRepeat -int 0z
defaults write com.apple.screencapture location -string "${HOME}/Desktop"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
chflags nohidden ~/Library
