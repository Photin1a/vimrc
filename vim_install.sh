#!/bin/bash
sudo apt update
sudo apt -y upgrade

#install python3.6
sudo apt install -y python3.6
sudo apt-get install -y libncurses5-dev
sudo apt-get install -y vim-gnome

cp .vimrc ~
#install latest vim
sudo apt remove  -y --purge vim   #uninstall vim
sudo apt install -y git
git clone https://github.com/vim/vim.git
cd ./vim
./configure --with-features=huge --enable-multibyte  --enable-pythoninterp=dynamic --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu --enable-python3interp=dynamic --with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu --enable-cscope --enable-gui=auto --enable-gtk2-check --enable-fontset --enable-largefile --disable-netbeans --with-compiledby="2574195342@qq.com" --enable-fail-if-missing --prefix=/usr/local
sudo make
sudo make install
cd .. && cd ..
sudo rm -rf vim

#sudo apt install -y clangd

#install nodejs 
sudo apt remove  -y --purge nodejs npm   #unstall nodejs 
sudo apt clean
sudo apt autoclean
sudo apt install -f
sudo apt -y autoremove
sudo apt install curl
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -  #添加nodejs18仓库
sudo apt-get install -y nodejs
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install -y yarn
echo "current npm version:"
npm -version
echo "current nodejs version:"
node -v

#install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
