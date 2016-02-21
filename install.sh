#!/bin/bash

# create backup directory
mkdir -p ~/backup

# add run privilige
chmod a+x ./mysql-auto-backup.sh ./auto-remove-outofdate-backup.sh

# TODO add mysql-auto-backup.sh to cron job
#write out current crontab
#crontab -l > mycron
#echo new cron into cron file
#echo "00 09 * * 1-5 echo hello" >> mycron
#install new cron file
#crontab mycron
#rm mycron
