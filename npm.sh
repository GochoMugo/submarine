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


# installs modules using npm
#
# ${*} arguments passed to `npm install`
# ${SUBMARINE_NPM_NICE}, ${NICE} can be provided to set process niceness
function install() {
  local nice_level=${NICE:-${SUBMARINE_NPM_NICE}}
  if [ "${nice_level}" ]
  then
    nice -n ${nice_level} npm install ${@}
  else
    npm install ${@}
  fi
}


# creates symbolic links for node_modules
#
# ${@} - module names
function ln_mod() {
  # ensure we do NOT mess up with ${NODE_HOME}
  # TODO: ignore a leading slash (/) in the ${NODE_HOME} variable
  # TODO: resolve ${NODE_HOME} if it is a symlink
  if [ "${PWD}/node_modules" == "${NODE_HOME}" ]
  then
    error "can not link modules in cwd"
    error "the modules are already in the ./node_modules/ directory"
    return 1
  fi

  # ensure ./node_modules/ and ./node_modules/.bin exist
  mkdir -p node_modules/.bin/

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
      ln -sf ${NODE_BIN}/$pkg node_modules/.bin/$pkg
      tick "${pkg}: linked executable"
    }
  done
}


# installing a node module in my top-most node_modules directory
#
# ${@} - module names
function g() {
  # move to the directory holding ${NODE_HOME}
  pushd "$(dirname ${NODE_HOME})" > /dev/null

  local installed=""
  local failed=""

  # do the installing
  for pkg in "$@"
  do
    install ${pkg}
    if [ $? ]
    then
      installed="${installed} ${pkg}"
    else
      failed="${failed} ${pkg}"
    fi
  done

  # after-success
  for pkg in "${installed}"
  do
    pkg=$(echo ${pkg} | grep -Eo "^[^@]*")
    tick "${pkg}: installed"
    gtrack ${pkg}
  done

  # report back failed installs
  for pkg in "${failed}"
  do
    cross "${pkg}: could not be installed"
  done

  popd > /dev/null
}


# install node module globally and link too
#
# ${@} - module names
function gln() {
  g "$@"
  ln_mod "$@"
}


# track globally installed node modules
#
# ${@} - module names
function gtrack() {
  local pkgs="$@"

  # we might want to track our installed modules
  if [[ -z ${pkgs} ]]
  then
    pkgs="$(ls ${NODE_HOME} | tr '\n' ' ')"
  fi

  # create the tracking file
  touch ${NODE_TRACK}

  for pkg in ${pkgs}
  do
    # ensure we do not add pkg name to the file, more than once
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
    [ -d "${NODE_HOME}/${pkg}" ] || install ${pkg}
  done
  popd > /dev/null
  success "restored successfully"
}


# removing a globally installed node module
#
# ${@} - module names
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
    install ${pkg}
  done
  popd > /dev/null
}


# check if node module is installed globally
#
# ${@} - module names
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
#
# ${@} - module names
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


# compare global and local versions
#
# ${1} - path to package.json
function compare() {
  local filepath="${1}"
  # default to $PWD/package.json if no path was provided
  [[ -z "${1}" ]] && {
    filepath="${PWD}/package.json"
  }
  # exit, if by now, we do not have a package.json
  [ -e "${filepath}" ] || {
    error "file not found"
    return 1
  }
  node "$(dirname ${BASH_SOURCE[0]})/lib/compare.js" "${filepath}"
  return $?
}
