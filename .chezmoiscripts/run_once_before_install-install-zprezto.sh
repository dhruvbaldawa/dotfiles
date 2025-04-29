#!/bin/sh

# Check if zprezto is already installed
if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  # Clone zprezto repository with submodules
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

  # Create symlinks for zprezto configuration files
  setopt EXTENDED_GLOB 2>/dev/null || true
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done

  # Optionally set zsh as default shell
  # chsh -s /bin/zsh
fi
