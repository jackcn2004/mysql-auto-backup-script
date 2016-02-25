#!/bin/bash

# create backup directory
mkdir -p ~/backup

# add run privilige
chmod a+x ./mysql-auto-backup.sh ./auto-remove-outofdate-backup.sh ./uninstall.sh

# add mysql-auto-backup.sh to cron job
#write out current crontab
currentDir=`pwd`
crontab -l > mycron
#echo new cron into cron file
echo "00 02 * * * ${currentDir}/mysql-auto-backup.sh" >> mycron # mysql database auto backup
echo "00 06 * * * ${currentDir}/auto-remove-outofdate-backup.sh" >> mycron # remove out of date backups
#install new cron file
crontab mycron
rm mycron
