# serf-rqlite
[rqlite] database cluster integrated with [Serf] and [HAProxy] for service discovery
---

[rqlite]: scripts/download.sh
[Serf]: https://www.serf.io/
[HAProxy]: http://www.haproxy.org/

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


