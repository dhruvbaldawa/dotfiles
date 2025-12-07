#!/bin/bash
set -e

REPO="dhruvbaldawa/dotfiles"
BRANCH="main"

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
  fi
fi

# Install Bun if not present
if ! command -v bun &> /dev/null; then
  echo "Installing Bun..."
  brew install oven-sh/bun/bun
fi

# Create temp directory and download scripts
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

echo "Downloading bootstrap scripts..."
curl -fsSL "https://raw.githubusercontent.com/${REPO}/${BRANCH}/scripts/package.json" -o "$TEMP_DIR/package.json"
curl -fsSL "https://raw.githubusercontent.com/${REPO}/${BRANCH}/scripts/bootstrap.ts" -o "$TEMP_DIR/bootstrap.ts"

# Install dependencies and run
cd "$TEMP_DIR"
bun install --silent
bun run bootstrap.ts
