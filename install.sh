echo 'You might need to change your default shell to zsh: `chsh -s /bin/zsh` (or `sudo vim /etc/passwd`)'

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
dir="$HOME/Code/dhruvbaldawa/dotfiles"
mkdir -p $dir
cd $dir
git clone git://github.com/dhruvbaldawa/dotfiles.git
cd dotfiles
sudo bash bin/symlink-dotfiles.sh
