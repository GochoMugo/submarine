
# npm


## design:

Read this [blog post](https://gochomugo.github.io/musings/global-node-modules/) on the assumed work-flow!


## usage:

1. Module require:

  ```bash
  msu_require "submarine.npm"
  ```

2. Shell Command: prefix `npm.`

  ```shell
  $ npm.g "express"
  ```

### `g(module_name [, module_name [, ...]])`

Installs the node modules globally.


### `ln_mod(module_name [, module_name [, ...]])`

Links the globally-installed node modules into cwd's `node_modules/`.


### `gln(module_name [, module_name [, ...]])`

Installs the node modules globally and links too. (`g` + `ln_mod`)


### `gtrack([module_name [, module_name [, ...]]])`

Tracks the node modules in `${HOME}/.node_modules`.


### `grestore()`

Restores globally-installed node modules using `${HOME}/.node_modules`.


### `gremove(module_name [, module_name [, ...]])`

Removes the globally-installed node module.


### `gupdate([module_name [, module_name [, ...]]])`

Updates the globally-installed node-modules. If no module name is passed, **all** the globally-installed node modules will be updated. If a node module does **not exist**, it will be installed.


### `ginstalled(module_name [, module_name [, ...]])`

Checks if the node modules are globally-installed.
