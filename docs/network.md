
# network

Perform network operations, easily.

How?

* common tasks such as checking if you are connected to internet, or a site is up


## usage:

1. **command:**

  ```bash
  $ msu run submarine.network.<command>
  ```

2. **module require:**

  ```bash
  msu_require "network"
  ```


## available commands:

### online([host1 [, host2 [, ...]]])

Checks if the hosts are online. If no host is provided as arguments, it uses `${SUBMARINE_PING_URL}`. If that is **not** set, it defaults to `duckduckgo.com`.

Alias: `net.online`
