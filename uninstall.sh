#!/bin/bash

backupDir=~/backup

# remove backup directory
if [ -d ${backupDir} ]; then
    rm -rf ${backupDir}
fi

#remove cron job
crontab -l
crontab -ir
