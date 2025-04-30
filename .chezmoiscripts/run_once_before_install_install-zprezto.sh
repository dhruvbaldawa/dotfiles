#!/usr/bin/env zsh

# Check if zprezto is already installed
if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  # Clone zprezto repository with submodules
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

  # Create symlinks for zprezto configuration files
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
fi

# Install antigen
if [ ! -d "$HOME/.antigen" ]; then
  mkdir -p "$HOME/.antigen"
  curl -L git.io/antigen > "$HOME/.antigen/antigen.zsh"
fi

if [ ! -f "/usr/local/bin/starship" ]; then
  curl -sS https://starship.rs/install.sh | sh
fi
