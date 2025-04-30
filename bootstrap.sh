#!/bin/bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
curl https://raw.githubusercontent.com/dhruvbaldawa/dotfiles/refs/heads/main/files/brew/Brewfile | brew bundle --file=- && \
gh auth login && \
gopass clone git@github.com:dhruvbaldawa/secrets.git && \
echo "Please share the GPG public key with me to continue the installation." && \
echo "Copy the exported key and ask user to run `gpg --import < keyfile`" && \
echo "After that, run `gopass sync`" && \
read -n 1 -s -r -p "Press any key to continue..." && \
gopass sync && \
echo "Please share the GPG public key with me to continue the installation." && \
chezmoi init --ssh dhruvbaldawa/dotfiles && \
chezmoi apply
# chezmoi
# starship
# nushell
# zsh
# atuin
# homebrew
