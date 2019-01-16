#!/bin/sh

pkill haproxy
pgrep -a haproxy

pkill serf
pgrep -a serf

pkill rqlite
pgrep -a rqlite