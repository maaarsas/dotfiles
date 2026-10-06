#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile), upgrading outdated ones
brew bundle install --upgrade

# Set up TMUX plugins
if [ -d ~/.tmux/plugins/tpm ]; then
  git -C ~/.tmux/plugins/tpm pull
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

mkdir -p ~/.config
ln -sfn ~/.dotfiles/ghostty ~/.config/ghostty
ln -sfn ~/.dotfiles/nvim ~/.config/nvim
ln -sfn ~/.dotfiles/smug ~/.config/smug

ln -sfn ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -sfn ~/.dotfiles/git/gitignore_global ~/.gitignore
ln -sfn ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -sfn ~/.dotfiles/zsh/zshrc ~/.zshrc
ln -sfn ~/.dotfiles/zsh/zshenv ~/.zshenv

# Machine-local zsh config lives outside this repo (it holds work tooling and
# credentials). Seed empty files so the sourcing in zshrc/zshenv is a no-op.
touch ~/.zshrc.local ~/.zshenv.local

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
