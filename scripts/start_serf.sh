#!/bin/sh

#   scripts/start_serf $SERVICE_NAME $NODE_NAME $SERF_MEMBER_IP $SERF_RPC_IP
set -eu

SERF_ROLE=$1
NODE_NAME=$2
SERF_MEMBER_IP=$3
SERF_RPC_IP=$4
SERF_SERVICE_IP=$5
RECEIVE=${6:-""}

MEMBER_CHECK=""
[[ -n "$RECEIVE" ]] && \
    MEMBER_CHECK="-event-handler member-join=$(pwd)/handlers/${SERF_ROLE}_serf_member_join.sh
     -event-handler member-leave,member-failed=handlers/${SERF_ROLE}_serf_member_left.sh"

JOIN=""
IFS=. read mip1 mip2 mip3 mip4 <<< "$SERF_MEMBER_IP"
[[ $mip4 != "1"  ]] && JOIN="-join $mip1.$mip2.$mip3.1"


bin/serf agent \
    -node=$NODE_NAME \
    -bind=$SERF_MEMBER_IP:9846 \
    -rpc-addr=$SERF_RPC_IP:7373 \
    $MEMBER_CHECK \
    $JOIN \
    -log-level debug \
    -tag service_ip=${SERF_SERVICE_IP} \
    -tag role=${SERF_ROLE} >> logs/serf_$NODE_NAME.log 2>&1 &
    

exit 0
