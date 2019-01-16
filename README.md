# serf-rqlite
[rqlite] database cluster integrated with [Serf] for service discovery
---

[rqlite]: scripts/download.sh
[Serf]: https://www.serf.io/


# Download the binaries
If you are using this repository for the first time, run the download.sh script do download both rqlite and Serf:

```sh
scripts/download.sh
```

Start the HAProxy and the Associated Serf Agent

```sh
scripts/start_all.sh
```
You should see a process list with an haproxy and a serf agent.


