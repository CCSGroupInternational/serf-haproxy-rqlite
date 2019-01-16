#!/bin/sh

# Start HAProxy
cp -p haproxy/haproxy.cfg haproxy/haproxy.cfg.tmp
haproxy -D -f haproxy/haproxy.cfg.tmp
pgrep -a haproxy

# Start HAProxy Serf agent
nohup scripts/start_serf.sh haproxy >/dev/null 2>&1

# Start rqlite
nohup scripts/start_rqlite.sh  >/dev/null 2>&1
pgrep -a rqlite

# Start rqlite Serf agent
nohup scripts/start_serf.sh rqlite 9847 7374 >/dev/null 2>&1

# Check Serf Nodes
pgrep -a serf



