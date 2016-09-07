# remove leftover dirs
sudo rm -rf ~/.config/nvim ~/.nvim

# remove packages & install dependencies
sudo apt-get remove --purge vim*
sudo apt-get install software-properties-common python-dev python-pip python3-dev python3-pip curl

# add PPA & install
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim

# update alternatives for vi,vim and $EDITOR
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor

# install python packages & vim-plug
pip2 install neovim
pip3 install neovim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# create symlinks for loading config
sudo ln -s ~/dotfiles/nvimrc ~/.config/nvim/init.vim
if [ ! -d ~/.nvim ]; then
    mkdir ~/.nvim
fi
sudo ln -s ~/dotfiles/nvimrc_minimal ~/.nvim/nvimrc_minimal
sudo ln -s ~/dotfiles/nvimfiles/sourceables ~/.nvim/sourceables
