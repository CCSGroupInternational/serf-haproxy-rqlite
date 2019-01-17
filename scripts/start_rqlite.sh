#!/bin/sh
set -eu

SERVICE_IP=$1

IFS=. read ip1 ip2 ip3 ip4 <<< "$SERVICE_IP"

JOIN=""
[[ $ip4 != "1"  ]] && JOIN="-join http://$ip1.$ip2.$ip3.1:4001"


bin/rqlited \
    -http-addr $SERVICE_IP:4001 \
    -raft-addr $SERVICE_IP:4002 \
    $JOIN \
    ~/rqlite_node_$ip4 >logs/rqlited_$ip4.log 2>&1 &


