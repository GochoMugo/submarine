
# services

Makes handling services easier during local development.

How?

* services store their data files at `${HOME}/services` thus allowing you to monitor the disk space used. If you want to reclaim back your space, you simply `rm -rf ${HOME}/services`
* only one process of the service is run; this helps avoid slowing down your computer with many redundant processes


## usage

1. **command:**

  ```bash
  $ msu run submarine.services.<command_name>
  ```

2. **module require:**

  ```bash
  msu_require "submarine.services"
  ```


## Available commands:

### start_mongo()

Start the `mongod` process as a daemon, if not running.


### stop_mongo()

Stops the `mongod` daemon, if running.


### start_redis()

Start the `redis-server` as a daemon, if not running.


### stop_redis()

Stops the `redis-server` daemon, if running.
