
# badges

Template badges quickly, using https://shields.io.

How?

* generate markdown links to your travis builds, npm packages, coveralls, etc.


## usage:

1. **command:**

  ```bash
  $ msu run submarine.badges.<command>
  ```

2. **module require:**

  ```bash
  msu_require "submarine.badges"
  ```


## available commands:

### markdown(username, reponame [, flag1 [, flag2])

Echos markdown links for badges. To disable a badge use the flag format `--no-<badge-name>` where `<badge-name>` is a name of the badge e.g. **travis**.
