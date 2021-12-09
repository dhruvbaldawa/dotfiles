echo 'You might need to change your default shell to zsh: `chsh -s /bin/zsh` (or `sudo vim /etc/passwd`)'

dir="$HOME/Code"
mkdir -p $dir
cd $dir
git clone git://github.com/dhruvbaldawa/dotfiles.git
cd dotfiles
sudo bash bootstrap-new-system.sh
sudo bash bin/symlink-dotfiles.sh
