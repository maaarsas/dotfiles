#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Set up TMUX
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

# Set up symlinks
ln -s ~/.dotfiles/nvim ~/.config/nvim

# Ghostty reads its config from Application Support on macOS
GHOSTTY_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
mkdir -p "$GHOSTTY_DIR"
ln -s ~/.dotfiles/ghostty/config "$GHOSTTY_DIR/config.ghostty"

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
