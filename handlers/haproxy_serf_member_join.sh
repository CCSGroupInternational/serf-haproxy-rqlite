#!/bin/sh

# The dynamic haproxy backend logic is based on:
#   https://www.haproxy.com/blog/dynamic-scaling-for-microservices-with-runtime-api/


echo
echo "New event: ${SERF_EVENT}. Data follows..."

while read line; do
    ROLE=`echo $line | awk '{print \$3 }'`
    if [ "${ROLE}" != "rqlite" ]; then
        continue
    fi
    SERVER_NAME=$(echo $line| awk '{ print $1}')
    SERVER_ADDRESS=$2
    TAGS=$(echo $line| awk '{ print $4}')
    # Obtain the service_ip from tags
    SERVICE_IP=$(echo $TAGS|egrep -o "service_ip=[^,]+"|cut -d= -f2)
    echo "set server rqlite-backend/$SERVER_NAME addr $SERVICE_IP" | socat stdio /tmp/haproxy.sock 
    echo "set server rqlite-backend/$SERVER_NAME state ready" | socat stdio /tmp/haproxy.sock 
done

exit 0
