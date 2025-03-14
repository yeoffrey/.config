#!/bin/bash

# Define the source and target paths
CONFIG_DIR="$HOME/.config"
ZSHRC_SOURCE="$CONFIG_DIR/.zshrc"
ZSHRC_TARGET="$HOME/.zshrc"

TMUX_SOURCE="$CONFIG_DIR/.tmux.conf"
TMUX_TARGET="$HOME/.tmux.conf"

# Remove existing .zshrc file
if [ -e "$ZSHRC_TARGET" ]; then
  echo "Removing existing .zshrc file in home directory."
  rm "$ZSHRC_TARGET"
fi

# Remove existing .tmux.conf file
if [ -e "$TMUX_TARGET" ]; then
  echo "Removing existing .tmux.conf file in home directory."
  rm "$TMUX_TARGET"
fi

# Create symlinks for .zshrc and .tmux.conf
echo "Creating symlink for .zshrc..."
ln -s "$ZSHRC_SOURCE" "$ZSHRC_TARGET"
echo ".zshrc symlink created successfully."

echo "Creating symlink for .tmux.conf..."
ln -s "$TMUX_SOURCE" "$TMUX_TARGET"
echo ".tmux.conf symlink created successfully."

# Install Homebrew if it's not already installed
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew
echo "Updating Homebrew..."
brew update

# Install command line packages
PACKAGES=(
  "eza"
  "figma"
  "fzf"
  "gh"
  "lazygit"
  "neovim"
  "node@22"
  "oven-sh/bun/bun"
  "pnpm"
  "ripgrep"
  "starship"
  "supabase/tap/supabase"
  "tmux"
  "zoxide"
  "zsh-autosuggestions"
  "zsh-syntax-highlighting"
)

INSTALLED_COUNT=0

echo "Installing command line packages..."
for PACKAGE in "${PACKAGES[@]}"; do
  if ! brew list --formula | grep -q "^$PACKAGE\$"; then
    brew install "$PACKAGE"
    INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
  fi
done

# Link node@22 to node only if node is not already linked
if brew list --formula | grep -q "^node@22\$" && ! command -v node &>/dev/null; then
  echo "Linking node@22 to node..."
  brew link --force --overwrite node@22
fi

# Install fonts and applications using Homebrew Cask
CASKS=(
  "1password"
  "font-jetbrains-mono-nerd-font"
  "notion"
  "openphone"
  "slack"
  "tidal"
  "todoist"
  "wezterm"
)

CASK_INSTALLED_COUNT=0

echo "Installing fonts and applications..."
for CASK in "${CASKS[@]}"; do
  if ! brew list --cask | grep -q "^$CASK\$"; then
    brew install --cask "$CASK"
    CASK_INSTALLED_COUNT=$((CASK_INSTALLED_COUNT + 1))
  fi
done

# Log if nothing was installed
if [ $INSTALLED_COUNT -eq 0 ] && [ $CASK_INSTALLED_COUNT -eq 0 ]; then
  echo "No new packages or casks were installed."
else
  echo "Installed $INSTALLED_COUNT command line packages and $CASK_INSTALLED_COUNT applications/fonts successfully."
fi

brew cleanup

echo "Please restart your shell to apply the changes."
