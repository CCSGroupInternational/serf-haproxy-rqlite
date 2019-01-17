#!/bin/sh

set -eu

mkdir -p logs

SERF_MEMBER_NET=127.0.10
SERF_RPC_NET=127.0.0
HAPROXY_NET=127.0.20
RQLITE_NET=127.0.30

source scripts/start_service_and_serf.sh

# Update the HAProxy template for the rqlite backend
sed "s/RQLITE_BACKEND/$RQLITE_NET.1:4001/g" haproxy/haproxy.cfg > haproxy/haproxy.cfg.tmp

start_service_and_serf HAPROXY 1 receive-member-events
start_service_and_serf RQLITE 1
start_service_and_serf RQLITE 2

sleep 1

bin/serf members
#pgrep -a rqlite; pgrep -a serf; pgrep -a haproxy

exit

