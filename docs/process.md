
# process

Handling processes better


## usage:

1. **command:**

  ```bash
  $ msu run submarine.process.<command>
  ```

2. **module require:**

  ```bash
  msu_require "submarine.process"
  ```


## available commands:

### running([processname1 [, processname2 [, ...]]])

Checks if processes with the given names, or started with executables with the given names are running on the machine. And how many of them.

Alias: `p.running`


### restart(command [, arg1 [, arg2 [, ...]]])

Kills all the processes seemingly started with executabls names `command` (using `pkill`) and restarts a new process using `command`.

Alias: `p.restart`


### retry([max_attempts, ] command [, arg1 [, arg2 [, ...]]])

Retries running the command `command` until a successful exit or number of attempts in running reach `max_attempts`. `max_attempts` defaults to 10.

Alias: `p.retry`
