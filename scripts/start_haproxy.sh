#!/bin/sh
set -eu

BIND_ADDR=$1

sed -i "s/IP_ADDR/$1/g" haproxy/haproxy.cfg  haproxy/haproxy.cfg.tmp
haproxy -D -f haproxy/haproxy.cfg.tmp
