#!/usr/bin/env zsh

# A simple script for setting up OSX dev environment.

dev="$HOME/Code/dotfiles"
mkdir -p "$HOME/bin"
pushd .
mkdir -p $dev
cd $dev

# If we on OS X, install homebrew and tweak system a bit.
if [[ `uname` == 'Darwin' ]]; then
  which -s brew
  if [[ $? != 0 ]]; then
    echo 'Installing Homebrew...'
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 
      brew update
      brew bundle --file "$dotfiles/etc/Brewfile"
      git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
      git clone https://github.com/zsh-users/antigen.git "$HOME/.antigen"
  fi

  echo 'Tweaking OS X...'
    source 'etc/osx.sh'
fi

# If on Linux, install zsh
if [[ `uname` != 'Darwin' ]]; then
  which -s zsh
  if [[ $? != 0 ]]; then
    echo 'Installing zsh and prezto...'
    sudo apt-get install zsh curl
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  fi
fi

echo 'Enter new hostname of the machine (e.g. macbook-paulmillr)'
  read hostname
  echo "Setting new hostname to $hostname..."
  scutil --set HostName "$hostname"
  compname=$(sudo scutil --get HostName | tr '-' '.')
  echo "Setting computer name to $compname"
  scutil --set ComputerName "$compname"

echo 'Checking for SSH key, generating one if it does not exist...'
  [[ -f '~/.ssh/id_rsa.pub' ]] || ssh-keygen -t rsa

echo 'Copying public key to clipboard. Paste it into your Github account...'
  [[ -f '~/.ssh/id_rsa.pub' ]] && cat '~/.ssh/id_rsa.pub' | pbcopy
  open 'https://github.com/account/ssh'

echo 'Symlinking config files...'
  source 'bin/symlink-dotfiles.sh'

echo 'Applying sublime config...'
  st=$(pwd)/sublime/packages
  as="$HOME/Library/Application Support/Sublime Text 3/Packages"
  asprefs="$as/User/Preferences.sublime-settings"
  if [[ -d "$as" ]]; then
    for theme in $st/Theme*; do
      cp -r $theme $as
    done
    rm $asprefs
    cp -r $st/pm-themes $as
    ln -s "$st/User/Preferences.sublime-settings" $asprefs
  else
    echo "Install Sublime Text http://www.sublimetext.com"
  fi

open_apps() {
  echo 'Install apps:'
  echo 'Firefox:'
  open http://www.mozilla.org/en-US/firefox/new/
  echo 'Dropbox:'
  open https://www.dropbox.com
  echo 'Chrome:'
  open https://www.google.com/intl/en/chrome/browser/
  echo 'Last.fm:'
  open http://www.last.fm/download
  echo 'Sequel Pro:'
  open http://www.sequelpro.com
  echo 'Skype:'
  open http://www.skype.com/en/download-skype/skype-for-computer/
  echo 'Toggl:'
  open https://www.toggl.com
  echo 'Tower:'
  open http://www.git-tower.com
  echo 'Transmission:'
  open http://www.transmissionbt.com
  echo 'VLC:'
  open http://www.videolan.org/vlc/index.html
  echo 'Pixelmator!'
}

echo 'Should I give you links for system applications (e.g. Skype, Tower, VLC)?'
echo 'n / y'
read give_links
[[ "$give_links" == 'y' ]] && open_apps

popd
