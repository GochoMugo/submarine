
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


### link([asset1 [, asset2 [, ...]]])

Create symlinks to the assets, in the current working directory.

Alias: `assets.ln`


### get([asset1 [, asset2 [, ...]]])

Retrieve assets.

Alias: `assets.get`


### put([asset1 [, asset2 [, ...]]])

Store assets.

Alias: `assets.put`

