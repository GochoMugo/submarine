
# npm


## design:

Read this [blog post](https://gochomugo.github.io/musings/global-node-modules/) on the assumed work-flow!


## usage:

1. **command:**

  ```shell
  $ msu run submarine.npm.<command>
  ```

2. Module require:

  ```bash
  msu_require "submarine.npm"
  ```


### `g(module_name [, module_name [, ...]])`

Installs the node modules globally.

Alias: `npm.g`


### `ln_mod(module_name [, module_name [, ...]])`

Links the globally-installed node modules into cwd's `node_modules/`.

Alias: `npm.ln_mod`


### `gln(module_name [, module_name [, ...]])`

Installs the node modules globally and links too. (`g` + `ln_mod`)

Alias: `npm.gln`


### `gtrack([module_name [, module_name [, ...]]])`

Tracks the node modules in `${HOME}/.node_modules`.

Alias: `npm.gtrack`


### `grestore()`

Restores globally-installed node modules using `${HOME}/.node_modules`.

Alias: `npm.grestore`


### `gremove(module_name [, module_name [, ...]])`

Removes the globally-installed node module.

Alias: `npm.gremove`


### `gupdate([module_name [, module_name [, ...]]])`

Updates the globally-installed node-modules. If no module name is passed, **all** the globally-installed node modules will be updated. If a node module does **not exist**, it will be installed.

Alias: `npm.gupdate`


### `ginstalled(module_name [, module_name [, ...]])`

Checks if the node modules are globally-installed.

Alias: `npm.ginstalled`


### `ln_grunt()`

Links all the **grunt** tasks' modules, registered in the `package.json` in the current working directory.

Alias: `npm.ln_grunt`


### `gversion([module_name [, module_name [, ...]]])`

Lists the version of the globally-installed node modules.

Alias: `npm.gversion`
