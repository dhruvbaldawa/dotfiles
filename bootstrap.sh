#!/bin/bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
curl https://raw.githubusercontent.com/dhruvbaldawa/dotfiles/refs/heads/main/files/brew/Brewfile | brew bundle --file=- && \
gopass clone git@github.com:dhruvbaldawa/secrets.git && \
gopass sync && \
# Export the GPG public key to the clipboard
echo "Please share the GPG public key with me to continue the installation." && \
chezmoi init --ssh dhruvbaldawa/dotfiles && \
chezmoi apply
# chezmoi
# starship
# nushell
# zsh
# atuin
# homebrew
