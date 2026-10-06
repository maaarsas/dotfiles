#!/bin/zsh

# Set explicit PATH
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

echo "Running Homebrew maintenance..."

# 1. Uninstall unneeded dependencies (orphaned packages)
brew autoremove

# 2. Remove old versions of installed formulas and clear download caches
# The '-s' flag wipes out the download cache entirely, freeing maximum disk space
brew cleanup -s

# 3. Clear Homebrew's temporary cache directory (~/Library/Caches/Homebrew)
#rm -rf "$(brew --cache)"

echo "Homebrew cleanup complete."
