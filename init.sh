#Start Up
BASE="$(cd "$(dirname "$0")"; pwd)/../"

while [[ -z "$username" || -z "$password" ]]; do
    clear;
    read -p "htpasswd Root Username: " username;
    read -p "htpasswd Root ROOT Password: " password;
    read -p "Is this information correct [Y/n]: " correct;
    
    if [ "$correct" == "n" ]; then
        username=;
        password=;
    fi
done
clear;

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
wget http://nodejs.org/dist/v0.8.19/node-v0.8.19.tar.gz
tar -zxf node-v0.8.19.tar.gz
cd node-v0.8.19
./configure && make && checkinstall --install=yes --pkgname=nodejs --pkgversion "0.8.19" --default
echo -e '\033[32mNode Install Complete \033[m'

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
chmod 777 /etc/apache2/*
mkdir /home/archived_users/
htpasswd -c -b /home/.htpasswd $username $password
service apache2 stop
rm -rf $BASE/base-init
exit
