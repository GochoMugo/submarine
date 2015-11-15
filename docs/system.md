
# system

Controlling the System.


## usage:

1. **command:**

  ```bash
  $ msu run submarine.system.<command>
  ```

2. **module require:**

  ```bash
  msu_require "submarine.system"
  ```


## available commands:

### down([duration])

Bring down the system (power off). **Duration** is in an integer and in minutes. If **duration** is provided, the power off occurs after the specified minutes.
Otherwise, the system will confirm with you, to shutdown the system immediately.

Alias: `sys.down`

