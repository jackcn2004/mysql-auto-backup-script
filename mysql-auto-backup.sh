#!/bin/bash

################################
# Config section
################################
dbuser=root # mysql user name
dbpassword=password # mysql password
databases=(phpmyadmin mysql) # database name that needed to be backup

################################
# Code section (DON'T CHANGE ANY CHARACTER!!)
################################
exportDir="." # 
dateFormat="%Y-%m-%d_%H-%M-%S"
ignoreTalbeList=(dataflow_batch_export dataflow_batch_import log_customer log_quote log_summary log_summary_type log_url log_url_info log_visitor log_visitor_info log_visitor_online index_event report_event report_compared_product_index report_viewed_product_index catalog_compare_item catalogsearch_query catalogsearch_fulltextcatalogsearch_result) # ignored table name list

# backup databases
syncFiles=()
for database in ${databases[@]}
do
    # make ignored table list
    params=""
    for table in ${ignoreTableList[@]}
    do
        params="${params} --ignore-table=${database}.${table}"
    done

    # export mysql data to sql format
    exportFile="${exportDir}/backup-${database}_`date +${dateFormat}`.sql" 
    mysqldump -u ${dbuser} -p${dbpassword} ${params} ${database}  > ${exportFile}

    if [ $? = 0 ]; then
        syncFiles+=(${exportFile})
    else
        echo "Removing ${exportFile}."
        rm ${exportFile}
    fi
done

for syncFile in ${syncFiles[@]}
do
    echo ${syncFile}
done
