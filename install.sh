echo 'You might need to change your default shell to zsh: `chsh -s /bin/zsh` (or `sudo vim /etc/passwd`)'

curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
dir="$HOME/Code/dhruvbaldawa/dotfiles"
mkdir -p $dir
cd $dir
git clone git://github.com/dhruvbaldawa/dotfiles.git
cd dotfiles
sudo bash bin/symlink-dotfiles.sh
