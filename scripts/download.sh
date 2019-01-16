#!/bin/sh

set -eu

RQLITE_VERSION=4.4.0
SERF_VERSION=0.8.1

RQLITE_ARCHIVE=rqlite-v${RQLITE_VERSION}-linux-amd64.tar.gz
SERF_ARCHIVE=serf_${SERF_VERSION}_linux_amd64.zip

rm -rf /tmp/rqlite-v${RQLITE_VERSION}-linux-amd64* \
    /tmp/${SERF_ARCHIVE} \
    /tmp/serf

wget https://github.com/rqlite/rqlite/releases/download/v${RQLITE_VERSION}/${RQLITE_ARCHIVE} -P /tmp
wget https://releases.hashicorp.com/serf/${SERF_VERSION}/${SERF_ARCHIVE}  -P /tmp

tar -C /tmp -xvf /tmp/${RQLITE_ARCHIVE}
unzip -d /tmp /tmp/$SERF_ARCHIVE
mkdir -p bin

mv /tmp/rqlite-v${RQLITE_VERSION}-linux-amd64/* bin
mv /tmp/serf bin
