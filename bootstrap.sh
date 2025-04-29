#!/bin/bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
curl https://raw.githubusercontent.com/dhruvbaldawa/dotfiles/refs/heads/main/files/brew/Brewfile | brew bundle --file=- && \
chezmoi init --ssh dhruvbaldawa/dotfiles
# chezmoi
# starship
# nushell
# zsh
# atuin
# homebrew
