#Start Up
BASE="$(cd "$(dirname "$0")"; pwd)/../"

#Update APT-GET
echo -e '\033[32mSystem Update \033[m'
apt-get -y update
apt-get -y upgrade
apt-get -y install curl
apt-get -y install inotify-tools
apt-get -y install libssl-dev pkg-config build-essential curl gcc g++ checkinstall
apt-get -y install python-software-properties
apt-get -y install software-properties-common
echo -e '\033[32mUpdate Completed\033[m'

#Install FTP
echo -e '\033[32mInstalling FTP\033[m'
sudo apt-get -y install vsftpd
cp $BASE/init/vsftpd.conf /etc/vsftpd.conf -fr
echo -e '\033[32mFTP Install Complete\033[m'

#Install Mysql
echo -e '\033[32mInstalling Mysql \033[m'
apt-get -y install mysql-server
mysql_install_db
echo -e '\033[32mMysql Install Complete \033[m'

#Install Nodes
echo -e '\033[32mInstalling Node \033[m'
mkdir /tmp/node-install
cd /tmp/node-install
git clone https://github.com/joyent/node.git
cd node
git checkout v0.10.7
./configure && make && sudo make install
echo -e '\033[32mNode Install Complete \033[m'

#Install Nodes Modules
echo -e '\033[32mInstalling Node Modules \033[m'
npm install forever -g
npm install jquery -g
npm install csslint -g
npm install jslint -g
echo -e '\033[32mNode Modules Install Complete \033[m'

#Install Java
echo -e '\033[32mInstalling Java \033[m'
apt-get -y update
apt-get -y install openjdk-7-jre
echo -e '\033[32mJava Install Complete \033[m'

#Install Vim
echo -e '\033[32mInstalling Vim \033[m'
apt-get -y remove vim-tiny
apt-get -y install vim
echo -e '\033[32mVim Install Complete \033[m'

#Configuring User Preferences
echo -e '\033[32mConfiguring User Preferences \033[m'
git config --global color.ui auto
git config --global core.editor "vim"
git config --global merge.tool vimdiff
export VISUAL=vim
export EDITOR=vim
echo -e '\033[32mConfigured User Preferences \033[m'

#Clean Up
chmod 751 /home
mkdir /home/archived_users/
rm -rf $BASE/base-init
exit
