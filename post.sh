#Start Up
BASE="$(cd "$(dirname "$0")"; pwd)"

#Install Nodes Modules
npm install express -g
npm install forever -g
npm install csslint -g
npm install jslint -g
npm install jsonlint -g

#Remove Crontab Reboot
touch $BASE/resetCron;
crontab $BASE/resetCron;

#Clean Up
chmod -R 777 /var/spool/cron
chmod 751 /home
mkdir /home/archived_users/
rm -rf $BASE
