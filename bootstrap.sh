#!/bin/bash
set -e

REPO="dhruvbaldawa/dotfiles"
BRANCH="main"
DOTFILES_DIR="$HOME/.dotfiles"

echo "🚀 Dotfiles Bootstrap"
echo ""

# Install Homebrew if not present
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH for this session
  if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  elif [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

# Install Bun if not present
if ! command -v bun &> /dev/null; then
  echo "Installing Bun..."
  brew install oven-sh/bun/bun
fi

# Clone the repo if not already present
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "Cloning dotfiles repository..."
  git clone "https://github.com/${REPO}.git" "$DOTFILES_DIR"

  # Switch remote to SSH for future operations
  cd "$DOTFILES_DIR"
  git remote set-url origin "git@github.com:${REPO}.git"
else
  echo "Dotfiles directory already exists, pulling latest..."
  cd "$DOTFILES_DIR"
  git pull
fi

# Run bootstrap script from the cloned repo
cd "$DOTFILES_DIR"
bun run scripts/bootstrap.ts
