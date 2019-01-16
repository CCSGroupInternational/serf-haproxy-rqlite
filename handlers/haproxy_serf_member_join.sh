#!/bin/sh
echo
echo "New event: ${SERF_EVENT}. Data follows..."

while read line; do
    ROLE=`echo $line | awk '{print \$3 }'`
    if [ "${ROLE}" != "rqlite" ]; then
        continue
    fi
    SERVER_NAME=$1
    SERVER_ADDRESS=$2

    echo "disable server rqlite-backend/rqlitesrv1" | socat stdio /tmp/haproxy.sock 
    echo $line | \
        awk '{ printf "    server %s %s:7946 check\n", $1, $2 }' >> haproxy/haproxy.cfg.tmp
    #pkill -HUP haproxy
done

exit 0
