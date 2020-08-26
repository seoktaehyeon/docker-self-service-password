#!/bin/bash

SSP_CONF="/var/www/html/conf/conf.inc.php"

# Check config file
[[ -f ${ENTRY_FILE} ]] || cp /opt/config.inc.php ${SSP_CONF}

# Update config file
for kv in $(env | grep ^SSP_)
do
    k=$(echo "$kv" | awk -F '=' '{print $1}' | awk -F '^SSP_' '{print $2}')
    v=$(echo "$kv" | awk -F '=' '{print $2}')
    if [[ "${v}" == "false" ]]; then
        sed -i "s#${k,,} =.*/${k,,} = false;#" $SSP_CONF
    elif [[ "${v}" == "true" ]]; then
        sed -i "s#${k,,} =.*/${k,,} = true;#" $SSP_CONF
    else
        sed -i "s#${k,,} =.*/${k,,} = '${v}';#" $SSP_CONF
    fi
done

# Start
docker-php-entrypoint
