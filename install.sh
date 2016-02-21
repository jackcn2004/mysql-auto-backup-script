#!/bin/bash

# create backup directory
mkdir -p ~/backup

# add run privilige
chmod a+x ./mysql-auto-backup.sh ./auto-remove-outofdate-backup.sh

# TODO add mysql-auto-backup.sh to cron job
