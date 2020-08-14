#!/bin/bash

ssp_conf_file="/var/www/html/conf/conf.inc.php"

for kv in $(env | grep ^SSP_)
do
    k=$(echo "$kv" | awk -F '=' '{print $1}' | awk -F '^SSP_' '{print $2}')
    v=$(echo "$kv" | awk -F '=' '{print $2}')
    sed -i "s/.*${k,,} .*/\$${k,,} = ${v}/" $ssp_conf_file
done

httpd-foreground
