#!/bin/sh
echo
echo "New event: ${SERF_EVENT}. Data follows..."

while read line; do
    ROLE=`echo $line | awk '{print \$3 }'`
    if [ "${ROLE}" != "rqlite" ]; then
        continue
    fi
    SERVER_NAME=$(echo $line| awk '{ print $1}')
    echo "set server rqlite-backend/$SERVER_NAME state maint" | socat stdio /tmp/haproxy.sock 
    #pkill -HUP haproxy
done

exit 0
