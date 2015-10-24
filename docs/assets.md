
# assets

Maintaining assets locally.

How?

* keep your assets in one place
* retrieve them anywhere
* etc...

## usage:

1. **command**:

  ```bash
  $ msu run submarine.assets.<command>
  ```

2. **module require**:

  ```bash
  msu_require "submarine.assets"
  ```


## available commands:

### where()

Return path to the assets library.

Alias: `assets.where`


### list()

List the assets.

Alias: `assets.list`


### get([asset1 [, asset2 [, ...]]])

Retrieve assets.

Alias: `assets.get`


### store([asset1 [, asset2 [, ...]]])

Store assets.

Alias: `assets.put`

