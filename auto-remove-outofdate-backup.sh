#!/bin/bash

keepFileNumber=2
backupDir="~/backup"

if [ `ls -1 ${backupDir} | wc -l` > ${keepFileNumber} ]; then
    ls -t1 ${backupDir} | tail -n+`expr ${keepFileNumber} + 1` | xargs -i rm -rf ${backupDir}/{}
fi
