#!/bin/bash

# macOS Defaults Configuration
# Inspired by mathiasbynens/dotfiles
# Run: ./macos/defaults.sh

set -e

echo "🔧 Applying macOS defaults..."

# Close System Preferences to prevent overrides
osascript -e 'tell application "System Preferences" to quit'

# Wait a moment
sleep 2

# ============================================================================
# Dock
# ============================================================================

echo "  • Configuring Dock..."

# Auto-hide Dock
defaults write com.apple.dock autohide -bool true

# Set Dock size (default 48)
defaults write com.apple.dock tilesize -int 48

# Magnification enabled
defaults write com.apple.dock magnification -bool true

# Magnification size
defaults write com.apple.dock largesize -int 80

# Position on screen (left, bottom, right)
defaults write com.apple.dock orientation -string "bottom"

# Minimize windows using Scale effect
defaults write com.apple.dock mineffect -string "scale"

# Minimize to application icon
defaults write com.apple.dock minimize-to-application -bool true

# Show indicator lights for open applications
defaults write com.apple.dock show-process-indicators -bool true

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# ============================================================================
# Finder
# ============================================================================

echo "  • Configuring Finder..."

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files (Cmd+Shift+.)
defaults write com.apple.finder AppleShowAllFiles -bool true

# Use list view in all Finder windows by default
# Four-letter codes: `icnv`, `Nlsv`, `clsv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# ============================================================================
# Keyboard & Input
# ============================================================================

echo "  • Configuring Keyboard..."

# Set key repeat rate (lowest: 2, highest: 120)
defaults write NSGlobalDomain KeyRepeat -int 2

# Set initial key repeat delay (lowest: 10, highest: 120)
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Enable Tab to move focus
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Enable spell check (but be less aggressive)
defaults write NSGlobalDomain NSSpellCheckerAutomaticSpellCheckingEnabled -bool true

# ============================================================================
# Screenshots
# ============================================================================

echo "  • Configuring Screenshots..."

# Save screenshots to Downloads folder
mkdir -p "$HOME/Downloads/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Downloads/Screenshots"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# ============================================================================
# Trackpad
# ============================================================================

echo "  • Configuring Trackpad..."

# Enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable three finger drag
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# Increase trackpad speed
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5

# ============================================================================
# Mission Control
# ============================================================================

echo "  • Configuring Mission Control..."

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# ============================================================================
# Security
# ============================================================================

echo "  • Configuring Security..."

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# ============================================================================
# Terminal
# ============================================================================

echo "  • Configuring Terminal..."

# Secure keyboard entry in Terminal
defaults write com.apple.Terminal SecureKeyboardEntry -bool true

# ============================================================================
# Safari
# ============================================================================

echo "  • Configuring Safari..."

# Show the full URL in the address bar (not just the domain)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Enable Developer Menu
defaults write com.apple.Safari IncludeDevelopMenu -bool true

# Enable the Web Inspector and Disable web security for development
defaults write com.apple.Safari WebKitDeveloperExtensionsEnabledPreferenceKey -bool true

# Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

# ============================================================================
# Activity Monitor
# ============================================================================

echo "  • Configuring Activity Monitor..."

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# ============================================================================
# Miscellaneous
# ============================================================================

echo "  • Configuring Miscellaneous settings..."

# Enable full keyboard access for all controls (Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable smart quotes and smart dashes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# ============================================================================
# Restart
# ============================================================================

echo ""
echo "✅ macOS defaults applied!"
echo ""
echo "⚠️  Note: Some changes require logout or restart."
echo "   You may need to:"
echo "   • Log out and log back in"
echo "   • Restart affected applications"
echo "   • Restart your Mac for some settings to take effect"
