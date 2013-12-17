#Start Up
BASE="$(cd "$(dirname "$0")"; pwd)"

#Update APT-GET
apt-get -y update
apt-get -y upgrade
apt-get -y install curl
apt-get -y install inotify-tools
apt-get -y install libssl-dev pkg-config build-essential curl gcc g++ checkinstall
apt-get -y install python-software-properties
apt-get -y install software-properties-common

#Install FTP
sudo apt-get -y install vsftpd
cp $BASE/vsftpd.conf /etc/vsftpd.conf -fr

#Install Mysql
apt-get -y install mysql-server
mysql_install_db

#Install Redis
apt-get -y install redis-server
cp $BASE/redis.conf /etc/redis/redis.conf
redis-server /etc/redis/redis.conf

#Install Nodes
apt-get -y install nodejs
curl https://raw.github.com/creationix/nvm/master/install.sh | sh
nvm install v0.10.7
nvm use v0.10.7

#Install Nodes Modules
npm install express -g
npm install forever -g
npm install csslint -g
npm install jslint -g
npm install jsonlint -g

#Install Java
apt-get -y update
apt-get -y install openjdk-7-jre

#Install Vim
apt-get -y remove vim-tiny
apt-get -y install vim

#Install NewRelic
echo deb http://apt.newrelic.com/debian/ newrelic non-free >> /etc/apt/sources.list.d/newrelic.list;
wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -;
apt-get update;
apt-get install -y newrelic-sysmond;
nrsysmond-config --set license_key=f3e8e80f017c8862e972bc5a1d69411fe57b1f95;
/etc/init.d/newrelic-sysmond start;

#Configure Firewall
apt-get -y install ufw
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow ssh
ufw allow ftp
if [ "$1" == "dev" ]; then
    ufw allow 3000:3010/tcp
fi
ufw enable

#Configuring System Preferences
cp $BASE/sshd_config /etc/ssh/sshd_config -fr
cp $BASE/banner /etc/ssh/banner -fr
echo "clear; cat /etc/ssh/banner" >> /etc/profile;

#Configuring User Preferences
git config --global color.ui auto
git config --global core.editor "vim"
git config --global merge.tool vimdiff
export VISUAL=vim
export EDITOR=vim

#SetUp Reboot Script
echo "@reboot $BASE/post.sh" >> $BASE/postCron;
crontab $BASE/postCron;

#Clean Up
shutdown -r 0
exit
