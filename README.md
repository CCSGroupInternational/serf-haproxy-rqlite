# serf-rqlite
[rqlite] database cluster integration with [Serf] and [HAProxy]
---

## Purpose
This repository provides a set of scripts and configuration templates for quickly setting up an high available load balanced rqlite backend.

[rqlite]: scripts/download.sh
[Serf]: https://www.serf.io/
[HAProxy]: http://www.haproxy.org/

## Disclaimer
This is a prototype setup, not recommended for production use.

## Components
- HAProxy: Reverse proxy for round robin delivery of the requests across the available rqlite nodes
- Serf: Discovery cluster for updating HAProxy's configuration when rqlite nodes join/leave the cluster
- rqlite: Replicated SQL cluster with multiple [read consistency] levels

[read consistency]: https://github.com/rqlite/rqlite/blob/master/DOC/CONSISTENCY.md


## Requirements
- Linux system with
    - HAProxy 1.8+
    - The `socat` utility

## Install

Run the download script to make sure you get the rqlite and serf versions that have been used for the integration.

Using a terminal
```sh
scripts/download.sh
```

Start the HAProxy and the Associated Serf Agent

```sh
scripts/start_all.sh
```
You should see a process list with an haproxy and a serf agent.


## Tests
```
scritps/test.sh
```

## Limitations

- Clients attempting to perform SQL operations that require strong consistency on non leader nodes will be redirected to the leader node address, as such, clients must be able to connect to the haproxy and to all the rqlite members. 
- Clients must explicitly resubmit their requests to the location provided in the HTTP redirect response
- Serf and rqlite are using the (default) unrestricted/insecure configuration
