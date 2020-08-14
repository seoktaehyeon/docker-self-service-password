#!/bin/bash

ssp_conf_file="/usr/local/apache2/htdocs/conf/conf.inc.php"

for kv in $(env | grep ^SSP_)
do
    k=$(echo "$kv" | awk -F '=' '{print $1}' | awk -F '^SSP_' '{print $2}')
    v=$(echo "$kv" | awk -F '=' '{print $2}')
    sed -i "s/.*${k,,} .*/\$${k,,} = ${v}/" $ssp_conf_file
done

service apache2 start

tail -f /var/log/apache2/access.log
