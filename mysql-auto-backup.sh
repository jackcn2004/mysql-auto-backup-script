#!/bin/bash

################################
# Config section
################################
dbuser="root" # mysql user name
dbpassword="password" # mysql password
databases=(phpmyadmin mysql) # database name that needed to be backup
scphost="127.0.0.1" # scp host IP address
scpuser="user" # scp user
scppassword="password" # scp user password
scpdir="/home/${scpuser}"

################################
# Code section (DON'T CHANGE ANY CHARACTER!!)
################################
backupDir="./backup" 
logFile="./backup.log"
datetimeFormat="%Y-%m-%d_%H-%M-%S"
onceBackupDir="${backupDir}/`date +${datetimeFormat}`"
ignoreTalbeList=(dataflow_batch_export dataflow_batch_import log_customer log_quote log_summary log_summary_type log_url log_url_info log_visitor log_visitor_info log_visitor_online index_event report_event report_compared_product_index report_viewed_product_index catalog_compare_item catalogsearch_query catalogsearch_fulltextcatalogsearch_result) # ignored table name list

# check backupDir exsists
if [ ! -d ${backupDir} ]; then
    echo "${backupDir} doesn't exsists."
    exit
fi

# create onceBackupDir
mkdir -p ${onceBackupDir}
if [ ! $? = 0 ]; then
    echo "Create ${onceBackupDir} failed."
    exit
fi

# backup databases
backupFiles=()
for database in ${databases[@]}
do
    backupFile="${onceBackupDir}/backup-${database}_`date +${datetimeFormat}`.sql" 

    # make ignored table list
    params=""
    for table in ${ignoreTableList[@]}
    do
        params="${params} --ignore-table=${database}.${table}"
    done

    # export mysql data to sql format
    mysqldump -u ${dbuser} -p${dbpassword} ${params} ${database}  > ${backupFile}

    if [ $? = 0 ]; then
        backupFiles+=(${backupFile})
    else
        echo "Removing ${backupFile}."
        rm ${backupFile}
    fi
done

if [ ! ${#databases[@]} = ${#backupFiles[@]} ]; then
    echo "Backup ${#backupFiles[@]} file(s) < ${#databases[@]} database(s)."
    rm -rf ${onceBackupDir}
    exit
fi

# compress backup files into tar.bz2 package
tar -cjf ${onceBackupDir}/backup_`date +${datetimeFormat}`.tar.bz2 ${onceBackupDir}/*.sql
