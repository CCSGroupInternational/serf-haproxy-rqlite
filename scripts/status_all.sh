#!/bin/sh

pgrep -a rqlite; pgrep -a serf; pgrep -a haproxy
bin/serf members