# handling npm functions
#
# Copyright (c) 2015 GochoMugo <mugo@forfuture.co.ke>


# modules
msu_require "console"
msu_require "fs"


# mod vars
DEPS="node npm"
NODE_HOME=~/node_modules
NODE_BIN=${NODE_HOME}/.bin
NODE_TRACK=~/.node_modules


# creates symbolic links for node_modules
function ln_mod() {
  [ ${PWD} == ${HOME} ] && return # dont link if in $HOME
  mkdir -p node_modules/ # ensure node_modules/ exists
  mkdir -p node_modules/.bin/ # and bin
  for pkg in "$@"
  do
    [ -d ${NODE_HOME}/${pkg} ] && {
      rm -rf $PWD/node_modules/${pkg}
      ln -sf ${NODE_HOME}/${pkg} $PWD/node_modules/${pkg}
      tick "${pkg}: linked module"
    } || {
      cross "${pkg}: missing module"
    }
    [ -x ${NODE_BIN}/${pkg} ] && {
      rm -rf node_modules/.bin/$pkg
      ln -fs ${NODE_BIN}/$pkg node_modules/.bin/$pkg
      tick "${pkg}: linked executable"
    }
  done
}


# installing a node module in my top-most node_modules directory
function g() {
  pushd ~ > /dev/null
  for pkg in "$@"
  do
    npm install ${pkg}
  done
  for pkg in "$@"
  do
    pkg=$(echo ${pkg} | grep -Eo "^[^@]*")
    [ -d ${NODE_HOME}/${pkg} ] && {
      tick "${pkg}: installed"
      gtrack ${pkg}
    } || {
      cross "${pkg}: could not be installed"
    }
  done
  popd > /dev/null
}


# install node module globally* and link too
function gln() {
  g "$@"
  ln_mod "$@"
}


# track globally installed node modules
function gtrack() {
  local pkgs="$@"
  [[ -z ${pkgs} ]] && pkgs="$(ls ${NODE_HOME} | tr '\n' ' ')"
  touch ${NODE_TRACK}
  for pkg in ${pkgs}
  do
    cat ${NODE_TRACK} | grep -e "^$pkg$" > /dev/null
    [ $? -ne 0 ] && {
      append ${NODE_TRACK} "${pkg}"
      tick "${pkg}: tracked"
    } || {
      tick "${pkg} (already tracked)"
    }
  done
}


# restore globally installed node modules from ~/.node_modules
function grestore() {
  local pkgs="$(cat ~/.node_modules | tr '\n' ' ')"
  pushd ~ > /dev/null
  for pkg in ${pkgs}
  do
    [ -d "${NODE_HOME}/${pkg}" ] || npm install ${pkg}
  done
  popd > /dev/null
  success "restored successfully"
}


# removing a globally installed node module
function gremove() {
  pushd ~ > /dev/null
  for pkg in "$@"
  do
    rm -r node_modules/${pkg}
    mv -f .node_modules .node_modules_tmp # temporary file
    cat .node_modules_tmp | grep -Ev "^${pkg}$" > .node_modules
    tick "removed ${pkg}"
  done
  rm .node_modules_tmp
  popd > /dev/null
}


# updates my top-most (global) node_modules
function gupdate() {
  pushd ~ > /dev/null
  local pkgs="$@"
  [[ -z ${pkgs} ]] && pkgs="$(ls node_modules | tr '\n' ' ')"
  for pkg in ${pkgs}
  do
    npm install ${pkg}
  done
  popd > /dev/null
}


# check if node module is installed globally
function ginstalled() {
  for pkg in "$@"
  do
    [ -d ${NODE_HOME}/${pkg} ] && {
      tick ${pkg}
     } || {
      cross ${pkg}
     }
  done
}


# linking for grunt tasks
function ln_grunt() {
  local mods=$(cat package.json | grep -Eo "\"grunt.*\":\s*\"" | grep -Eo "[a-Z\-]+" | tr '\n' ' ')
  ln_mod ${mods}
}


# list versions of globally-installed modules
function gversion() {
  local pkgs="${@}"
  [[ -z ${pkgs} ]] && pkgs="$(ls ${NODE_HOME} | tr '\n' ' ')"
  for pkg in ${pkgs}
  do
    if [ -d "${NODE_HOME}/${pkg}" ]
    then
      local version=$(cat ${NODE_HOME}/${pkg}/package.json | grep -E "\"version\":" | grep -Eo "[0-9\.]+")
      tick "${pkg} - ${version}"
    else
      cross "${pkg} (not installed)"
    fi
  done
}
