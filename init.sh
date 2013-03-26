#Start Up
BASE="$(cd "$(dirname "$0")"; pwd)/../"

#Update APT-GET
echo -e '\033[32mSystem Update \033[m'
apt-get -y update
apt-get -y upgrade
apt-get -y install curl
apt-get -y install libssl-dev pkg-config build-essential curl gcc g++ checkinstall
apt-get -y install python-software-properties
apt-get -y install software-properties-common
echo -e '\033[32mUpdate Completed\033[m'

#Install FTP
echo -e '\033[32mInstalling FTP\033[m'
sudo apt-get -y install vsftpd
cp $BASE/init/vsftpd.conf /etc/vsftpd.conf -fr
echo -e '\033[32mFTP Install Complete\033[m'

#Install Apache2
echo -e '\033[32mInstalling Apache2\033[m'
apt-get -y install apache2
a2dissite default
echo -e '\033[32mApache2 Install Complete\033[m'

#Install Apache2 Modules
echo -e '\033[32mInstalling Apache2 Modules\033[m'
apt-get -y install libapache2-mod-auth-plain
apt-get -y install libapache2-mod-proxy-html
apt-get -y install libapache2-mod-php5
apt-get -y install libapache2-mod-uwsgi
apt-get -y install libapache2-mod-vhost-hash-alias
apt-get -y install libapache2-webauth
apt-get -y install libapr-memcache0
apt-get -y install libapr-memcache-dev
apt-get -y install libapache2-mod-auth-mysql
apt-get -y install libxml2-dev
a2enmod rewrite
a2enmod suexec
a2enmod include
a2enmod userdir
a2enmod deflate
a2enmod proxy
a2enmod proxy_http
echo -e '\033[32mApache2 Modules Install Complete\033[m'

#Install Mysql
echo -e '\033[32mInstalling Mysql \033[m'
apt-get -y install mysql-server
mysql_install_db
echo -e '\033[32mMysql Install Complete \033[m'

#Install PHP
echo -e '\033[32mInstalling PHP \033[m'
apt-get -y install php5
cp $BASE/init/php.ini /etc/php5/apache2/php.ini -fr
echo -e '\033[32mPHP Install Complete \033[m'

#Install PHP Modules
echo -e '\033[32mInstalling PHP Modules \033[m'
apt-get -y install php5-cgi php5-cli php5-common php5-curl php5-dbg php5-mcrypt
apt-get -y install php5-dev php5-mysql php5-odbc php5-fpm libphp5-embed php5-mysql
apt-get -y install php5-mysqlnd php5-memcache php5-imap php5-geoip php5-ldap
echo -e '\033[32mPHP Modules Install Complete \033[m'

#Install Nodes
echo -e '\033[32mInstalling Node \033[m'
mkdir /tmp/node-install
cd /tmp/node-install
wget http://nodejs.org/dist/v0.8.19/node-v0.8.19.tar.gz
tar -zxf node-v0.8.19.tar.gz
cd node-v0.8.19
./configure && make && checkinstall --install=yes --pkgname=nodejs --pkgversion "0.8.19" --default
echo -e '\033[32mNode Install Complete \033[m'

#Install Node Modules
echo -e '\033[32mInstalling Node Modules \033[m'
npm link mysql
npm link mysql-queues
npm link socket.io
echo -e '\033[32mNode Modules Install Complete \033[m'

#Install Java
echo -e '\033[32mInstalling Java \033[m'
apt-get update
apt-get install openjdk-7-jre
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
export VISUAL=vim
export EDITOR=vim
echo -e '\033[32mConfigured User Preferences \033[m'

#Clean Up
read -p "htpasswd dev username: " username
read -p "htpasswd dev password: " password
htpasswd -c -b $BASE/.htpasswd $username $password
service apache2 reload
service apache2 restart
rm -r $BASE/base-init
exit
