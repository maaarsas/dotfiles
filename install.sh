#!/bin/sh

DOTFILES=$(cd -- "$(dirname -- "$0")" && pwd)

echo "Setting up your Mac..."

if ! command -v brew >/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update
brew bundle install --upgrade --file "$DOTFILES/homebrew/Brewfile"
"$DOTFILES/homebrew/setup-cleanup-job.sh"

# Homebrew doesn't package gh extensions, so gh/extensions is their manifest.
if command -v gh >/dev/null; then
  while read -r extension; do
    case $extension in '' | \#*) continue ;; esac
    gh extension install "$extension" 2>/dev/null || true
  done < "$DOTFILES/gh/extensions"
  gh extension upgrade --all
fi

# enabledPlugins in settings.json only toggles plugins that are already
# installed, so the download has to happen here.
if command -v claude >/dev/null; then
  for plugin in gopls-lsp lua-lsp ruby-lsp; do
    claude plugin install "$plugin@claude-plugins-official" || true
  done
fi

if [ -d "$HOME/.tmux/plugins/tpm" ]; then
  git -C "$HOME/.tmux/plugins/tpm" pull
else
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

link() {
  mkdir -p "$(dirname "$2")"
  ln -sfn "$DOTFILES/$1" "$2"
}

link .tmux.conf           "$HOME/.tmux.conf"
link claude/CLAUDE.md     "$HOME/.claude/CLAUDE.md"
link claude/settings.json "$HOME/.claude/settings.json"
link gh/dash.yml          "$HOME/.config/gh-dash/config.yml"
link ghostty              "$HOME/.config/ghostty"
link git/gitconfig        "$HOME/.gitconfig"
link git/gitignore_global "$HOME/.gitignore"
link nvim                 "$HOME/.config/nvim"
link smug                 "$HOME/.config/smug"
link zsh/zshenv           "$HOME/.zshenv"
link zsh/zshrc            "$HOME/.zshrc"

# Machine-local zsh config lives outside this repo (it holds work tooling and
# credentials). Seed empty files so the sourcing in zshrc/zshenv is a no-op.
touch "$HOME/.zshrc.local" "$HOME/.zshenv.local"

# Last: this restarts Finder, Dock and friends.
bash "$DOTFILES/.macos"