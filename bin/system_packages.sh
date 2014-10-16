#!/usr/bin/env bash
BACKUP_DIR="/Users/dhruv/.backup"
BREW_SCRIPT_NAME="$BACKUP_DIR/restore_homebrew.sh"
PYTHON_PACKAGE_LIST="$BACKUP_DIR/python_packages.txt"
ITERM_CONFIG="$BACKUP_DIR/iterm.config"

if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi

# Stolen from http://www.topbug.net/blog/2013/12/07/back-up-homebrew-packages/
echo "Creating homebrew restore script"

echo '#!/bin/bash' > "$BREW_SCRIPT_NAME"
echo '' >> "$BREW_SCRIPT_NAME"
echo 'failed_items=""' >> "$BREW_SCRIPT_NAME"
echo 'function install_package() {' >> "$BREW_SCRIPT_NAME"
echo 'echo EXECUTING: brew install $1 $2' >> "$BREW_SCRIPT_NAME"
echo 'brew install $1 $2' >> "$BREW_SCRIPT_NAME"
echo '[ $? -ne 0 ] && $failed_items="$failed_items $1" # package failed to install.' >> "$BREW_SCRIPT_NAME"
echo '}' >> "$BREW_SCRIPT_NAME"

brew tap | while read tap; do echo "brew tap $tap" >> "$BREW_SCRIPT_NAME"; done

brew list | while read item;
do
    echo "install_package $item '$(brew info $item | /usr/bin/grep 'Built from source with:' | /usr/bin/sed 's/^[ \t]*Built from source with:/ /g; s/\,/ /g')'" >> "$BREW_SCRIPT_NAME"
done

echo '[ ! -z $failed_items ] && echo The following items were failed to install: && echo $failed_items' >> "$BREW_SCRIPT_NAME"

# make the homebrew restore script executable
chmod +x "$BREW_SCRIPT_NAME"

echo "Backing up python packages"
pip freeze > "$PYTHON_PACKAGE_LIST"
