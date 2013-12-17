#Start Up
BASE="$(cd "$(dirname "$0")"; pwd)"

#Set Node Version
nvm install v0.10.7
nvm use v0.10.7

#Install Nodes Modules
npm install express -g
npm install forever -g
npm install csslint -g
npm install jslint -g
npm install jsonlint -g

#Remove Crontab Reboot
touch $BASE/mycron;
crontab $BASE/mycron;

#Clean Up
chmod -R 777 /var/spool/cron
chmod 751 /home
mkdir /home/archived_users/
rm -rf $BASE
shutdown -r 0
exit
