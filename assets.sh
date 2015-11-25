#
# maintaining assets locally
#


# modules
msu_require "console"


# module variables
DEPS=
ASSETS_LIB="${SUBMARINE_ASSETS_LIB:-${HOME}/.assets}"


# ensure library is created
mkdir -p "${ASSETS_LIB}"


# show where library is at
function where() {
  echo "${ASSETS_LIB}"
}


# listing assets
function list() {
  ls "${ASSETS_LIB}"
}


# retrieve assets
function get() {
  for asset in "${@}"
  do
    cp -r "${ASSETS_LIB}/${asset}" .
    if [ $? ] ; then
      tick ${asset}
    else
      cross ${asset}
    fi
  done
}


# create symbolic links to assets
function link() {
  for asset in "${@}"
  do
    # for convenience, catch typos, etc.
    if [ ! -f "${ASSETS_LIB}/${asset}" ]
    then
      error "'${asset}' does not exist"
      continue
    fi
    ln -sf "${ASSETS_LIB}/${asset}" "${asset}"
  done
}


# store assets
function put() {
  for asset in "${@}"
  do
    cp -r "${asset}" "${ASSETS_LIB}"
    if [ $? ] ; then
      tick ${asset}
    else
      cross ${asset}
    fi
  done
}
