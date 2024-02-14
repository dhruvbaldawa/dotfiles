#!/bin/bash

dev="$HOME/Code"
dotfiles="$dev/dotfiles"
bin="$HOME/bin"

if [[ -d "$dotfiles" ]]; then
  echo "Symlinking dotfiles from $dotfiles"
else
  echo "$dotfiles does not exist"
  exit 1
fi

link() {
  from="$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  rm "$to"
  ln -s "$from" "$to"
}

for location in "$dotfiles"/home/*; do
  file="${location##*/}"
  file="${file%.*}"
  link "$location" "$HOME/.$file"
done

for location in "$dotfiles"/bin/*; do
  file="${location##*/}"
  file="${file%.*}"
  link "$location" "$bin/$file"
done

for location in "$dotfiles"/config/*; do
  file="${location##*/}"
  link "$location" "$HOME/.$file"
done


if [[ `uname` == 'Darwin' ]]; then
#  link "$dotfiles/sublime/Packages/User/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
  link "$dotfiles/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
fi

link "$dotfiles/terminal/prompt_dhruv_setup" "$HOME/.zprezto/modules/prompt/functions/prompt_dhruv_setup"
link "$dotfiles/bin/z.sh" "$bin/z"
