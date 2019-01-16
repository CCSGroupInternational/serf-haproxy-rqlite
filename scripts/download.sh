#!/bin/sh

set -eu

RQLITE_VERSION=4.4.0
SERF_VERSION=0.8.1

RQLITE_ARCHIVE=rqlite-v${RQLITE_VERSION}-linux-amd64.tar.gz
SERF_ARCHIVE=serf_${SERF_VERSION}_linux_amd64.zip
rm -rf ${RQLITE_ARCHIVE} ${SERF_ARCHIVE} rqlite-v${RQLITE_VERSION}-linux-amd64 serf

wget https://github.com/rqlite/rqlite/releases/download/v${RQLITE_VERSION}/${RQLITE_ARCHIVE}
wget https://releases.hashicorp.com/serf/${SERF_VERSION}/${SERF_ARCHIVE}

tar xvf ${RQLITE_ARCHIVE}
unzip $SERF_ARCHIVE
mkdir -p bin
mv rqlite-v${RQLITE_VERSION}-linux-amd64/* bin
mv serf bin