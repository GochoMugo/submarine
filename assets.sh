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
