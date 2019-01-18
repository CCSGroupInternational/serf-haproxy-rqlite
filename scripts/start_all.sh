#!/bin/sh

set -eu

mkdir -p logs

export SERF_MEMBER_NET=127.0.10
export SERF_RPC_NET=127.0.0
export HAPROXY_NET=127.0.20
export RQLITE_NET=127.0.30

source scripts/start_service_and_serf.sh

# Update the HAProxy template for the rqlite backend

start_service_and_serf HAPROXY 1 receive-member-events
start_service_and_serf RQLITE 1
start_service_and_serf RQLITE 2

echo -----
bin/serf members
#pgrep -a rqlite; pgrep -a serf; pgrep -a haproxy

exit

