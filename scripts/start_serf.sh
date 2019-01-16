#!/bin/sh

set -eu

SERF_ROLE=$1
SERF_PORT=${2:-9846} 
RPC_PORT=${3:-7373}
MEMBER_CHECK=${MEMBER_CHECK:-""}


JOIN=""

# If not the first node, join with the first node
[[ "$SERF_PORT" != "9846" ]] && JOIN="-join 127.0.0.1:9846"
[[ -n "$MEMBER_CHECK" ]] && \
    MEMBER_CHECK="-event-handler member-join=$(pwd)/handlers/${SERF_ROLE}_serf_member_join.sh
     -event-handler member-leave,member-failed=handlers/${SERF_ROLE}_serf_member_left.sh"


bin/serf agent \
    $JOIN \
    -node=$SERF_ROLE \
    -bind=0.0.0.0:$SERF_PORT \
    -rpc-addr=127.0.0.1:$RPC_PORT \
    $MEMBER_CHECK \
    -tag role=${SERF_ROLE} >> logs/serf_${SERF_ROLE}.log 2>&1 &
    #-log-level=debug \
