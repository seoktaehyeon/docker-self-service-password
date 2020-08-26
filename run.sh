#!/bin/bash

SSP_CONF="/var/www/html/conf/conf.inc.php"

# Check config file
if [[ -f ${SSP_CONF} ]]; then
	[[ -z "$(cat ${SSP_CONF})" ]] && {
	    mv ${SSP_CONF} ${SSP_CONF}.$(date +%N)
	    cp /opt/config.inc.php ${SSP_CONF}
	}
else
    cp /opt/config.inc.php ${SSP_CONF}
fi

# Start
docker-php-entrypoint
